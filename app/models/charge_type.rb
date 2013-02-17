class ChargeType < ActiveRecord::Base
  attr_accessible :name, :account_id, :counts_towards_spending

  # Concerns
  include Searchable, Deletable

  # Named Scopes

  # Model Validations
  validates_presence_of :name, :account_id

  # Model Relationships
  belongs_to :account
  has_many :entries, order: :billing_date, conditions: ['entries.deleted = ?', false]

  # ChargeType Methods

  def full_name
    self.name + ' - ' + self.account.name
  end

  # type: :amount, :charged_amount
  def contribution(type)
    result = self.entries.sum(&type)
    self.counts_towards_spending ? result * -1 : result
  end

  def total_spent
    self.counts_towards_spending? ? self.entries.sum(&:amount) : 0
  end

  def spent_in_time_period(start_date, end_date)
    self.counts_towards_spending? ? self.entries.with_date_for_calendar(start_date, end_date).sum(&:amount) : 0
  end
end
