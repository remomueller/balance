# frozen_string_literal: true

# Stores the total value of a single account. Can have multiple charge types
# that can count towards spending or be transfers.
class Account < ApplicationRecord
  # Triggers
  after_create_commit :create_transfer_charge_type

  # Constants
  CATEGORIES = [%w(Savings savings), %w(Investments investments)]

  # Concerns
  include Searchable, Deletable, Squishable

  squish :name

  # Model Validation
  validates :name, presence: true
  validates :category, inclusion: { in: CATEGORIES.collect(&:second) }

  # Model Relationships
  belongs_to :user
  has_many :charge_types, -> { current.order(:name) }

  # Account Methods

  def total_spent
    @total_spent ||= begin
      charge_types.collect(&:total_spent).sum
    end
  end

  # type: :amount, :charged_amount
  def balance(type)
    charge_types.collect { |c| c.contribution(type) }.sum
  end

  def spent_in_time_period(start_date, end_date)
    @spent_in_time_period ||= begin
      charge_types.collect { |item| item.spent_in_time_period(start_date, end_date) }.sum
    end
  end

  def average_spent_over_time_period(start_date, end_date)
    @average_spent_over_time_period ||= begin
      spent_in_time_period(start_date, end_date) / (end_date - start_date + 1.0)
    end
  end

  def category_name
    Account.category_name(category)
  end

  def self.category_name(category)
    CATEGORIES.find { |_name, value| value == category }.first
  rescue
    'Uncategorized'
  end

  def create_transfer_charge_type
    charge_types.create(name: 'Transfer', counts_towards_spending: false)
  end
end
