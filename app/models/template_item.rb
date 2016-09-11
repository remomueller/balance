# frozen_string_literal: true

# Defines a templated entry
class TemplateItem < ApplicationRecord
  # Model Validation
  validates :name, :template_id, :charge_type_id, presence: true

  # Model Relationships
  belongs_to :template
  belongs_to :charge_type

  # Model Methods

  def decimal_amount
    '%0.02f' % (amount / 100.0) if amount.present?
  end

  def decimal_amount=(decimal_amount_input)
    if (decimal_amount_input =~ /^([-])?([0-9]*)([.]+[0-9]{0,2})?$/) != nil
      self.amount = (100 * decimal_amount_input.to_f).round
    else
      self.amount = decimal_amount_input
    end
  end
end
