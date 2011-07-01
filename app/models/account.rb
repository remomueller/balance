class Account < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :user
  has_many :charge_types, :order => :name, :conditions => ['charge_types.deleted = ?', false]
  
  scope :current, :conditions => { :deleted => false }
  scope :search, lambda { |*args| {:conditions => [ 'LOWER(accounts.name) LIKE ?', '%' + args.first.downcase.split(' ').join('%') + '%' ] } }

  def destroy(real = false)
    unless real
      update_attribute :deleted, true
    else
      super()
    end
  end
  
  def total_spent
    @total_spent ||= begin
      self.charge_types.collect(&:total_spent).sum
    end
  end
  
  def balance
    @balance ||= begin
      self.charge_types.collect(&:balance_contribution).sum
    end
  end

  def charged_balance
    @charged_balance ||= begin
      self.charge_types.collect(&:charged_balance_contribution).sum
    end
  end

  def spent_in_time_period(start_date, end_date)
    @spent_in_time_period ||= begin
      self.charge_types.collect{|item| item.spent_in_time_period(start_date,end_date)}.sum
    end
  end
  
  def average_spent_over_time_period(start_date, end_date)
    @average_spent_over_time_period ||= begin
      self.spent_in_time_period(start_date, end_date) / (end_date - start_date + 1.0)
    end
  end
  
end
