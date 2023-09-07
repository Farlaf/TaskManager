require 'test_helper'

class Web::RecoverPasswordsControllerTest < ActionController::TestCase
  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should generate link' do
    password = generate(:string)
    user = create(:user, { password: password })
    attrs = {
      email: user.email,
    }
    post :create, params: { recover_password_form: attrs }
    assert_response :redirect
  end
end
