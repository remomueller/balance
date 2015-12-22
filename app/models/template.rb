# Defines a group of entry templates that can be launched starting on a specific
# date.
class Template < ActiveRecord::Base
  # Concerns
  include Deletable

  # Named Scopes

  # Model Validations
  validates :name, :user_id, presence: true
  validates :name, uniqueness: { scope: [:user_id, :deleted], case_sensitive: false }

  # Model Relationships
  belongs_to :user

  # Template Methods
end
