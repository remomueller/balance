class ChargeType < ActiveRecord::Base

  # Concerns
  include Searchable, Deletable

  # Named Scopes

  # Model Validations
  validates_presence_of :name, :account_id

  # Model Relationships
  belongs_to :account
  has_many :entries, -> { where(deleted: false).order(:billing_date) }

  # ChargeType Methods

  def full_name
    self.name + ' - ' + self.account.name
  end

  # type: :amount, :charged_amount
  def contribution(type)
    result = self.entries.collect(&type).sum
    self.counts_towards_spending ? result * -1 : result
  end

  def total_spent
    self.counts_towards_spending? ? self.entries.collect(&:amount).sum : 0
  end

  def spent_in_time_period(start_date, end_date)
    self.counts_towards_spending? ? self.entries.with_date_for_calendar(start_date, end_date).collect(&:amount).sum : 0
  end
end
