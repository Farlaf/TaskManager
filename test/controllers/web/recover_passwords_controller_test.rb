require 'test_helper'

class Web::RecoverPasswordsControllerTest < ActionController::TestCase
  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create link' do
    password = generate(:string)
    user = create(:user, { password: password })
    attrs = {
      email: user.email,
    }
    assert_emails 1 do
      post :create, params: { password_recovery: attrs }
    end
    assert_response :redirect
  end

  test 'should get edit' do
    password = generate(:string)
    token = 'test'
    create(:user, { password: password, reset_token: token, reset_expire: 24.hour.from_now })
    get :edit, params: { token: token }
  end

  test 'should post update' do
    password = generate(:string)
    user = create(:user, { password: password })

    attrs = {
      email: user.email,
    }
    post :create, params: { password_recovery: attrs }

    token = user.reload.reset_token
    reset_attrs = {
      password: 'new_pass',
      password_confirmation: 'new_pass',
    }
    post :update, params: { token: token, password_set: reset_attrs }

    assert_not_equal user.password_digest, user.reload.password_digest
    assert_response :redirect
  end
end
