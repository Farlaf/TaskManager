require 'test_helper'

class Web::DeveloperControllerTest < ActionController::TestCase
  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should post create' do
    post :create, params: { developer: attributes_for(:developer) }
    assert_response :redirect
  end
end
