class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, and :lockable
  devise :database_authenticatable, :registerable, :timeoutable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :accounts, :order => :name, :conditions => ['accounts.deleted = ?', false]
  has_many :announcements
  has_many :charge_types, :through => :accounts, :order => :name, :conditions => ['charge_types.deleted = ?', false]
  has_many :entries, :order => 'billing_date desc, id desc', :conditions => ['entries.deleted = ?', false]
  
  def total_expenditures
    @total_spent ||= begin
      self.accounts.collect(&:total_spent).sum
    end
  end
  
  def first_billing_date
    @first_billing_date ||= begin
      self.entries.collect{|a| a.billing_date}.min
    end
  end
  
  def average_expenditures_per_day
    @average_expenditures_per_day ||= begin
      (self.total_expenditures / (Date.today - first_billing_date)).to_f.to_currency
    end
  end
  
  def average_expenditures_per_month
    @average_expenditures_per_month ||= begin
      (self.total_expenditures / (Date.today - first_billing_date) * 30.0).to_f.to_currency
    end
  end
  
  def average_expenditures_per_year
    @average_expenditures_per_year ||= begin
      (self.total_expenditures / (Date.today - first_billing_date) * 365.0).to_f.to_currency
    end
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
  
  def name
    first_name + ' ' + last_name
  end
  
  def reverse_name
    last_name + ', ' + first_name
  end
end
