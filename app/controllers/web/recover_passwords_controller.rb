class Web::RecoverPasswordsController < Web::ApplicationController
  include RecoverPasswordsHelper
  before_action :get_user, :token_correct?, only: [:edit, :update]

  def new
    @recover = RecoverPasswordFormNew.new
  end

  def create
    @recover = RecoverPasswordFormNew.new(recover_params)

    if @recover.valid?
      user = @recover.user

      token = SecureRandom.urlsafe_base64
      expire_time = 24.hour.from_now
      user.update!({ reset_token: token, reset_expire: expire_time })

      UserMailer.with({ user: user }).recover_password.deliver_now

      flash[:notice] = 'Link to generate new password send to your email'
      redirect_to(root_url)
    else
      render(:new)
    end
  end

  def edit
    @new_password = RecoverPasswordFormEdit.new
  end

  def update
    @new_password = RecoverPasswordFormEdit.new(new_pass_params)

    render(:edit) if !@new_password.valid?

    @user.update({
                   password: @new_password.password,
                   password_confirmation: @new_password.password_confirmation,
                   reset_token: nil,
                   reset_expire: nil,
                 })

    flash[:notice] = 'Password updated, use new password'
    redirect_to(:new_session)
  end

  private

  def recover_params
    params.require(:recover_password_form_new).permit(:email)
  end

  def new_pass_params
    params.require(:recover_password_form_edit).permit(:password, :password_confirmation)
  end
end
