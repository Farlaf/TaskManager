class Web::RecoverPasswordsController < Web::ApplicationController
  def new
    @recover = PasswordRecovery.new
  end

  def create
    @recover = PasswordRecovery.new(recover_params)
    return render(:new) if @recover.invalid?

    user = @recover.user
    RecoverPasswordService.create_reset_token!(user)

    SendRecoverPasswordLinkJob.perform_async(user.id)
    redirect_to(root_url, notice: 'Link to generate new password send to your email')
  end

  def edit
    @new_password = PasswordSet.new
    return user_not_found if user.nil?

    redirect_to(new_recover_password_path, notice: 'incorrect token') if RecoverPasswordService.token_invalid?(user)
  end

  def update
    @new_password = PasswordSet.new(new_pass_params)
    return render(:edit) if @new_password.invalid?
    return user_not_found if user.nil?

    RecoverPasswordService.set_password!(user, @new_password.password)
    redirect_to(:new_session, notice: 'Password updated, use new password')
  end

  private

  def recover_params
    params.require(:password_recovery).permit(:email)
  end

  def new_pass_params
    params.require(:password_set).permit(:password, :password_confirmation)
  end

  def user
    @user ||= User.find_by_reset_token(params[:token])
  end

  def user_not_found
    redirect_to(root_url, notice: 'user not found')
  end
end
