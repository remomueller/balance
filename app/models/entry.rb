# frozen_string_literal: true

# Defines a certain amount and description of the charge or transfer.
class Entry < ApplicationRecord
  # Concerns
  include Searchable, Deletable, Squishable

  squish :name

  # Named Scopes
  scope :with_date_for_calendar, lambda { |*args|
    where('DATE(entries.billing_date) >= ? and DATE(entries.billing_date) <= ?', args.first, args[1])
  }

  # Model Validations
  validates :name, :amount, :billing_date, presence: true
  validates :amount, numericality: true

  # Model Relationships
  belongs_to :user
  belongs_to :charge_type

  # Entry Methods

  def copyable_attributes
    attributes.reject { |key, _val| %w(id billing_date user_id deleted).include?(key.to_s) }
  end

  def charged_amount
    charged? ? amount : 0
  end

  def decimal_amount
    format('%0.02f', (amount / 100.0)) unless amount.blank?
  end

  def decimal_amount=(decimal_amount_input)
    self.amount = if !(decimal_amount_input =~ /^([-])?([0-9]*)([.]+[0-9]{0,2})?$/).nil?
                    (100 * decimal_amount_input.to_f).round
                  else
                    decimal_amount_input
                  end
  end
end
