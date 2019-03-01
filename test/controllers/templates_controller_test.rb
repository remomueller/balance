# frozen_string_literal: true

require "test_helper"

# Tests to assure that templates can be created and modified.
class TemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @template = templates(:one)
  end

  test "should get index" do
    login(users(:regular))
    get templates_url
    assert_response :success
  end

  test "should get new" do
    login(users(:regular))
    get new_template_url
    assert_response :success
  end

  test "should create template" do
    login(users(:regular))
    assert_difference("Template.count") do
      post templates_url, params: { template: { name: "New Template" } }
    end
    assert_equal "New Template", Template.last.name
    assert_equal users(:regular), Template.last.user
    assert_redirected_to template_url(Template.last)
  end

  test "should not create template with blank name" do
    login(users(:regular))
    assert_difference("Template.count", 0) do
      post templates_url, params: { template: { name: "" } }
    end
    assert_response :success
  end

  test "should not create template with identical name" do
    login(users(:regular))
    assert_difference("Template.count", 0) do
      post templates_url, params: { template: { name: "monthly bills" } }
    end
    assert_response :success
  end

  test "should show template" do
    login(users(:regular))
    get template_url(@template)
    assert_response :success
  end

  test "should get edit" do
    login(users(:regular))
    get edit_template_url(@template)
    assert_response :success
  end

  test "should update template" do
    login(users(:regular))
    patch template_url(@template), params: { template: { name: @template.name } }
    assert_redirected_to template_url(@template)
  end

  test "should destroy template" do
    login(users(:regular))
    assert_difference("Template.current.count", -1) do
      delete template_url(@template)
    end
    assert_redirected_to templates_url
  end
end
