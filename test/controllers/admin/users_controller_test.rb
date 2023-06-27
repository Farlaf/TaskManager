require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  setup do
    admin = create(:admin)
    sign_in admin
    @user = create(:user)
  end

  test 'should get show' do
    get :show, params: { id: @user.id }
    assert_response :success
  end

  test 'shoul get index' do
    get :index
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @user.id }
    assert_response :success
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'shold post create' do
    user_attrs = attributes_for(:user)
    post :create, params: { user: user_attrs }
    assert_response :redirect
  end

  test 'should patch update' do
    user_attrs = attributes_for(:user)
    patch :update, params: { id: @user.id, user: user_attrs }
    assert_response :redirect
  end

  test 'should delete destroy' do
    delete :destroy, params: { id: @user.id }
    assert_response :redirect
  end
end
