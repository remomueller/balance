require 'simplecov'

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
  
  def login(user)
    @request.env["devise.mapping"] = Devise.mappings[user]
    sign_in(:user, user)
  end
end

class ActionController::IntegrationTest
  def sign_in_as(user_template, password, email)
    user = User.create(:password => password, :password_confirmation => password, :email => email,
                       :first_name => user_template.first_name, :last_name => user_template.last_name)
    user.save!
    post_via_redirect 'users/login', :user => {:email => email, :password => password}
    user
  end
end