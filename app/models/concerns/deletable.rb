module Deletable
  extend ActiveSupport::Concern

  included do
    scope :current, -> { where deleted: false }
  end

  def destroy
    update_column :deleted, true
  end
end
