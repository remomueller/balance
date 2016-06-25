# frozen_string_literal: true

require 'test_helper'

# Test to assure regular user can generate a backup.
class InternalControllerTest < ActionController::TestCase
  setup do
    @regular_user = users(:valid)
  end

  test 'should get backup' do
    login(@regular_user)
    get :backup
    assert_response :success
  end

  test 'should generate backup' do
    login(@regular_user)
    post :generate_backup
    assert_redirected_to backup_succeeded_path
  end
end
