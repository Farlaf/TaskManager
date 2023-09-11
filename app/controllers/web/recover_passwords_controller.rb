class Web::RecoverPasswordsController < Web::ApplicationController
  def new
    @recover = RecoverPasswordFormNew.new
  end

  def create
    @recover = RecoverPasswordFormNew.new(recover_params)

    return render(:new) if @recover.invalid?

    user = @recover.user

    token = SecureRandom.urlsafe_base64
    expire_time = 24.hour.from_now
    user.update!({ reset_token: token, reset_expire: expire_time })

      UserMailer.with({ user: user }).recover_password.deliver_later

    flash[:notice] = 'Link to generate new password send to your email'
    redirect_to(root_url)
  end

  def edit
    @new_password = RecoverPasswordFormEdit.new
    get_user_by_token
  end

  def update
    @new_password = RecoverPasswordFormEdit.new(new_pass_params)
    @user ||= get_user_by_token

    return render(:edit) if @new_password.invalid?

    @user.update({
                   password: @new_password.password,
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

  def get_user_by_token
    user = User.find_by(reset_token: params[:token])
    return redirect_to(root_url, notice: 'user not found') if user.blank?
    return redirect_to(new_recover_password_path, notice: 'incorrect token') if user.reset_expire < Time.now

    user
  end
end
