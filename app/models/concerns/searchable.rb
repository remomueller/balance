module Searchable
  extend ActiveSupport::Concern

  included do
    scope :search, lambda { |arg| where('LOWER(name) LIKE ?', arg.to_s.downcase.gsub(/^| |$/, '%')) }
  end

end
