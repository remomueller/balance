# frozen_string_literal: true

# Associates entries as transfers or charges to related accounts.
class ChargeType < ApplicationRecord
  # Concerns
  include Searchable, Deletable, Squishable

  squish :name

  # Named Scopes

  # Model Validations
  validates :name, presence: true

  # Model Relationships
  belongs_to :account
  has_many :entries, -> { current.order(:billing_date) }

  # ChargeType Methods

  def full_name
    "#{name} - #{account.name}"
  end

  # type: :amount, :charged_amount
  def contribution(type)
    result = entries.collect(&type).sum
    counts_towards_spending ? result * -1 : result
  end

  def total_spent
    counts_towards_spending? ? entries.collect(&:amount).sum : 0
  end

  def spent_in_time_period(start_date, end_date)
    counts_towards_spending? ? entries.with_date_for_calendar(start_date, end_date).collect(&:amount).sum : 0
  end
end
