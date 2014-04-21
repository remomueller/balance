require 'simplecov'

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers

  def login(resource)
    @request.env["devise.mapping"] = Devise.mappings[resource]
    sign_in(resource.class.name.downcase.to_sym, resource)
  end
end

class ActionDispatch::IntegrationTest
  def sign_in_as(user_template, password, email)
    user = User.create(password: password, password_confirmation: password, email: email,
                       first_name: user_template.first_name, last_name: user_template.last_name)
    user.save!
    post_via_redirect 'users/login', user: { email: email, password: password }
    user
  end
end

module Rack
  module Test
    class UploadedFile
      def tempfile
        @tempfile
      end
    end
  end
end
