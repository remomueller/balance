class ChargeType < ActiveRecord::Base
  validates_presence_of :name, :account_id
  belongs_to :account
  has_many :entries, order: :billing_date, conditions: ['entries.deleted = ?', false]

  scope :current, conditions: { deleted: false }
  scope :search, lambda { |*args| {conditions: [ 'LOWER(charge_types.name) LIKE ?', '%' + args.first.downcase.split(' ').join('%') + '%' ] } }

  def destroy(real = false)
    unless real
      update_attribute :deleted, true
    else
      super()
    end
  end

  def full_name
    self.name + ' - ' + self.account.name
  end

  def balance_contribution
    if self.counts_towards_spending
      (self.entries.collect(&:amount).sum * -1)
    else
      self.entries.collect(&:amount).sum
    end
  end

  def charged_balance_contribution
    if self.counts_towards_spending
      (self.entries.collect(&:charged_amount).sum * -1)
    else
      self.entries.collect(&:charged_amount).sum
    end
  end

  def total_spent
    @total_spent ||= begin
      if self.counts_towards_spending
        self.entries.collect(&:amount).sum
      else
        0
      end
    end
  end

  def spent_in_time_period(start_date, end_date)
    @spent_in_time_period ||= begin
      if self.counts_towards_spending
        self.entries.where(['DATE(billing_date) >= ? and DATE(billing_date) <= ?', start_date, end_date]).collect(&:amount).sum
      else
        0
      end
    end
  end
end
