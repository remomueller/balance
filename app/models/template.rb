# frozen_string_literal: true

# Defines a group of entry templates that can be launched starting on a specific
# date.
class Template < ApplicationRecord
  # Concerns
  include Deletable, Squishable, Searchable

  squish :name

  attr_accessor :item_hashes
  after_save :set_items

  # Named Scopes

  # Model Validations
  validates :name, presence: true
  validates :name, uniqueness: { scope: [:user_id, :deleted], case_sensitive: false }

  # Model Relationships
  belongs_to :user
  has_many :template_items, -> { order :position }

  # Template Methods

  private

  def set_items
    return unless item_hashes && item_hashes.is_a?(Array)
    template_items.destroy_all
    item_hashes.each_with_index do |hash, index|
      charge_type = user.charge_types.find_by_id hash[:charge_type_id]
      decimal_amount = hash[:decimal_amount].to_s.gsub(/[\s$,]/, '')
      template_items.create(charge_type_id: charge_type.id, position: index, name: hash[:name], decimal_amount: decimal_amount, description: hash[:description]) if charge_type
    end
  end
end
