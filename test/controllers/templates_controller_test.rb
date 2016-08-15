# frozen_string_literal: true

require 'test_helper'

# Tests to assure that templates can be created and modified.
class TemplatesControllerTest < ActionController::TestCase
  setup do
    @template = templates(:one)
  end

  test 'should get index' do
    login(users(:regular))
    get :index
    assert_response :success
    assert_not_nil assigns(:templates)
  end

  test 'should get new' do
    login(users(:regular))
    get :new
    assert_response :success
  end

  test 'should create template' do
    login(users(:regular))
    assert_difference('Template.count') do
      post :create, template: { name: 'New Template' }
    end
    assert_not_nil assigns(:template)
    assert_equal 'New Template', assigns(:template).name
    assert_equal users(:regular), assigns(:template).user
    assert_redirected_to template_path(assigns(:template))
  end

  test 'should not create template with blank name' do
    login(users(:regular))
    assert_difference('Template.count', 0) do
      post :create, template: { name: '' }
    end

    assert_not_nil assigns(:template)
    assert assigns(:template).errors.size > 0
    assert_equal ["can't be blank"], assigns(:template).errors[:name]

    assert_response :success
  end

  test 'should not create template with identical name' do
    login(users(:regular))
    assert_difference('Template.count', 0) do
      post :create, template: { name: 'monthly bills' }
    end

    assert_not_nil assigns(:template)
    assert assigns(:template).errors.size > 0
    assert_equal ['has already been taken'], assigns(:template).errors[:name]

    assert_response :success
  end

  test 'should show template' do
    login(users(:regular))
    get :show, id: @template
    assert_response :success
  end

  test 'should get edit' do
    login(users(:regular))
    get :edit, id: @template
    assert_response :success
  end

  test 'should update template' do
    login(users(:regular))
    patch :update, id: @template, template: { name: @template.name }
    assert_redirected_to template_path(assigns(:template))
  end

  test 'should destroy template' do
    login(users(:regular))
    assert_difference('Template.current.count', -1) do
      delete :destroy, id: @template
    end

    assert_redirected_to templates_path
  end
end
