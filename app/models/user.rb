class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  # Concerns
  include Deletable

  has_many :accounts, -> { where deleted: false }
  has_many :charge_types, -> { where deleted: false }, through: :accounts
  has_many :entries, -> { where deleted: false }
  has_many :templates, -> { current }

  def total_expenditures
    @total_expenditures ||= begin
      self.accounts.collect(&:total_spent).sum
    end
  end

  def first_billing_date
    self.entries.order(:billing_date).first.billing_date if self.entries.size > 0
  end

  def total_spent_per_day
    @total_spent_per_day ||= begin
      self.entries.size > 0 ? (self.total_expenditures / (Date.today - first_billing_date)).to_f : 0.0
    end
  end

  def average_expenditures_per_day
    self.total_spent_per_day.to_currency
  end

  def average_expenditures_per_month
    (self.total_spent_per_day * 30.0).to_currency
  end

  def average_expenditures_per_year
    (self.total_spent_per_day * 365.0).to_currency
  end

  def spent_in_time_period(start_date, end_date)
    @spent_in_time_period ||= begin
      self.accounts.collect{|item| item.spent_in_time_period(start_date,end_date)}.sum
    end
  end

  def average_spent_over_time_period(start_date, end_date)
    @average_spent_over_time_period ||= begin
      self.accounts.collect{|item| item.average_spent_over_time_period(start_date,end_date)}.sum
    end
  end

  # gross_spending is true, gross_income is false
  def gross(start_date, end_date, counts_towards_spending)
    result = entries_in_time_period(start_date, end_date, counts_towards_spending).collect{|e| e.amount}.sum
    result = result * -1 if counts_towards_spending
    (result / 100.0).round(2)
  end

  def entries_in_time_period(start_date, end_date, counts_towards_spending)
    self.entries.with_date_for_calendar(start_date, end_date).select{|e| e.charge_type.counts_towards_spending? == counts_towards_spending}
  end

  # Get the net_profit for a month or for a year...
  def net_profit(start_date, end_date)
    (gross(start_date, end_date, true) + gross(start_date, end_date, false)).round(2)
  end

  def name
    first_name + ' ' + last_name
  end

  def reverse_name
    last_name + ', ' + first_name
  end
end
