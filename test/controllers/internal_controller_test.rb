# frozen_string_literal: true

require "test_helper"

# Test to assure regular user can generate a backup.
class InternalControllerTest < ActionDispatch::IntegrationTest
  setup do
    @regular_user = users(:valid)
  end

  test "should get backup" do
    login(@regular_user)
    get backup_url
    assert_response :success
  end

  test "should generate backup" do
    login(@regular_user)
    post generate_backup_url
    assert_redirected_to backup_succeeded_url
  end
end
