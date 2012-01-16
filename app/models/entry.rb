class Entry < ActiveRecord::Base
  validates_presence_of :name, :charge_type_id, :amount, :billing_date, :user_id
  validates_numericality_of :amount
  
  belongs_to :user
  belongs_to :charge_type
  
  scope :current, :conditions => { :deleted => false }
  scope :search, lambda { |*args| {:conditions => [ 'LOWER(name) LIKE ?', '%' + args.first.downcase.split(' ').join('%') + '%' ] } }
  scope :with_charged, lambda { |*args| { :conditions => ["entries.charged = ? or 1 = ?", args.first, args.first]} }
  scope :with_date_for_calendar, lambda { |*args| { :conditions => ["DATE(entries.billing_date) >= ? and DATE(entries.billing_date) <= ?", args.first, args[1]]}}
  scope :with_user, lambda { |*args| { :conditions => ["user_id IN (?)", args.first] } }
  
  def copyable_attributes
    self.attributes.reject{|key, val| ['id', 'billing_date'].include?(key.to_s)}
  end
  
  def destroy(real = false)
    unless real
      update_attribute :deleted, true
    else
      super()
    end
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
