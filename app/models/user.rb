# frozen_string_literal: true

# Defines the user login, accounts, and entries.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  # Concerns
  include Deletable, Squishable

  squish :first_name, :last_name

  has_many :accounts, -> { current }
  has_many :charge_types, -> { current }, through: :accounts
  has_many :entries, -> { current }
  has_many :templates, -> { current }

  def total_expenditures
    accounts.collect(&:total_spent).sum
  end

  def first_billing_date
    entries.order(:billing_date).first.billing_date if entries.size > 0
  end

  def total_spent_per_day
    if entries.size > 0
      (total_expenditures / (Time.zone.today - first_billing_date)).to_f
    else
      0.0
    end
  end

  def average_expenditures_per_day
    total_spent_per_day.to_currency
  end

  def average_expenditures_per_month
    (total_spent_per_day * 30.0).to_currency
  end

  def average_expenditures_per_year
    (total_spent_per_day * 365.0).to_currency
  end

  def spent_in_time_period(start_date, end_date)
    accounts.collect { |item| item.spent_in_time_period(start_date, end_date) }.sum
  end

  def average_spent_over_time_period(start_date, end_date)
    accounts.collect { |item| item.average_spent_over_time_period(start_date, end_date) }.sum
  end

  # gross_spending is true, gross_income is false
  def gross(start_date, end_date, counts_towards_spending)
    result = entries_in_time_period(start_date, end_date, counts_towards_spending).sum(:amount)
    result = result * -1 if counts_towards_spending
    (result / 100.0).round(2)
  end

  def entries_in_time_period(start_date, end_date, counts_towards_spending)
    entries.with_date_for_calendar(start_date, end_date)
           .joins(:charge_type)
           .where(charge_types: { counts_towards_spending: counts_towards_spending })
  end

  # Get the net_profit for a month or for a year...
  def net_profit(start_date, end_date)
    (gross(start_date, end_date, true) + gross(start_date, end_date, false)).round(2)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def reverse_name
    "#{last_name}, #{first_name}"
  end
end
