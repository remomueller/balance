module Searchable
  extend ActiveSupport::Concern

  included do
    scope :search, lambda { |arg| where("LOWER(#{self.table_name}.name) LIKE ?", arg.to_s.downcase.gsub(/^| |$/, '%')) }
  end

end
