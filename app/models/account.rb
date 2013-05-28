class Account < ActiveRecord::Base

  # Concerns
  include Searchable, Deletable

  # Named Scopes

  # Model Validation
  validates_presence_of :name

  # Model Relationships
  belongs_to :user
  has_many :charge_types, -> { where(deleted: false).order(:name) }

  # Account Methods

  def total_spent
    @total_spent ||= begin
      self.charge_types.collect(&:total_spent).sum
    end
  end

  # type: :amount, :charged_amount
  def balance(type)
    self.charge_types.collect{|c| c.contribution(type)}.sum
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
