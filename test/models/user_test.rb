# frozen_string_literal: true

require 'test_helper'

SimpleCov.command_name 'test:models'

# Unit tests for user methods
class UserTest < ActiveSupport::TestCase
  test 'should get total expenditures' do
    assert users(:valid).total_expenditures.is_a?(Fixnum)
  end

  test 'should get average expenditures per day' do
    assert users(:valid).average_expenditures_per_day.is_a?(String)
  end

  test 'should get average expenditures per month' do
    assert users(:valid).average_expenditures_per_month.is_a?(String)
  end

  test 'should get average expenditures per year' do
    assert users(:valid).average_expenditures_per_year.is_a?(String)
  end

  test 'should get reverse name' do
    assert_equal 'LastName, FirstName', users(:valid).reverse_name
  end
end
