class Entry < ActiveRecord::Base
  attr_accessible :name, :charge_type_id, :billing_date, :decimal_amount, :amount, :description, :charged

  # Concerns
  include Searchable, Deletable

  # Named Scopes
  scope :with_date_for_calendar, lambda { |*args| { conditions: ["DATE(entries.billing_date) >= ? and DATE(entries.billing_date) <= ?", args.first, args[1]]}}
  scope :with_user, lambda { |*args| { conditions: ["user_id IN (?)", args.first] } }

  # Model Validations
  validates_presence_of :name, :charge_type_id, :amount, :billing_date, :user_id
  validates_numericality_of :amount

  # Model Relationships
  belongs_to :user
  belongs_to :charge_type

  # Entry Methods

  def copyable_attributes
    self.attributes.reject{|key, val| ['id', 'billing_date', 'user_id', 'deleted'].include?(key.to_s)}
  end

  def charged_amount
    if charged?
      amount
    else
      0
    end
  end

  def decimal_amount
    "%0.02f" % (self.amount / 100.0) unless self.amount.blank?
  end

  def decimal_amount=(decimal_amount_input)
    if (decimal_amount_input =~ /^([-])?([0-9]*)([.]+[0-9]{0,2})?$/) != nil
      self.amount = (100 * decimal_amount_input.to_f).round
    else
      self.amount = decimal_amount_input
    end
  end
end
