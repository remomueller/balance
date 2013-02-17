class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :lockable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  scope :current, conditions: { deleted: false }

  has_many :authentications
  has_many :accounts, conditions: { deleted: false } # ['accounts.deleted = ?', false]
  has_many :charge_types, through: :accounts, conditions: { deleted: false } # ['charge_types.deleted = ?', false]
  has_many :entries, conditions: { deleted: false } # ['entries.deleted = ?', false]

  def total_expenditures
    @total_spent ||= begin
      self.accounts.collect(&:total_spent).sum
    end
  end

  def first_billing_date
    self.entries.order(:billing_date).first.billing_date if self.entries.size > 0
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

  # gross_spending is true, gross_income is false
  def gross(start_date, end_date, counts_towards_spending)
    result = entries_in_time_period(start_date, end_date, counts_towards_spending).sum{|e| e.amount}
    result = result * -1 if counts_towards_spending
    result
  end

  def entries_in_time_period(start_date, end_date, counts_towards_spending)
    self.entries.with_date_for_calendar(start_date, end_date).select{|e| e.charge_type.counts_towards_spending? == counts_towards_spending}
  end

  # Get the net_profit for a month or for a year...
  def net_profit(start_date, end_date)
    gross(start_date, end_date, true) + gross(start_date, end_date, false)
  end

  def name
    first_name + ' ' + last_name
  end

  def reverse_name
    last_name + ', ' + first_name
  end

  # Overriding Devise built-in active? method
  def active_for_authentication?
    super # and self.status == 'active' and not self.deleted?
  end

  def apply_omniauth(omniauth)
    unless omniauth['info'].blank?
      self.email = omniauth['info']['email'] if email.blank?
      self.first_name = omniauth['info']['first_name'] if first_name.blank?
      self.last_name = omniauth['info']['last_name'] if last_name.blank?
    end
    authentications.build( provider: omniauth['provider'], uid: omniauth['uid'] )
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
end
