class Web::RecoverPasswordsController < Web::ApplicationController
  def new
    @recover = RecoverPassword.new
  end

  def create
    @recover = RecoverPassword.new(recover_params)
    return render(:new) if @recover.invalid?

    user = @recover.user
    RecoverPasswordService.create_reset_token!(user)

    UserMailer.with({ user: user }).recover_password.deliver_now
    redirect_to(root_url, notice: 'Link to generate new password send to your email')
  end

  def edit
    @new_password = NewPassword.new
    return user_not_found if user.nil?

    redirect_to(new_recover_password_path, notice: 'incorrect token') if RecoverPasswordService.token_invalid?(user)
  end

  def update
    @new_password = NewPassword.new(new_pass_params)
    return render(:edit) if @new_password.invalid?
    return user_not_found if user.nil?

    RecoverPasswordService.set_password!(user, @new_password.password)
    redirect_to(:new_session, notice: 'Password updated, use new password')
  end

  private

  def recover_params
    params.require(:recover_password).permit(:email)
  end

  def new_pass_params
    params.require(:new_password).permit(:password, :password_confirmation)
  end

  def user
    @user ||= User.find_by_reset_token!(params[:token])
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def user_not_found
    redirect_to(root_url, notice: 'user not found')
  end
end
