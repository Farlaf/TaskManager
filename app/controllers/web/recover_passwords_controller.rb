class Web::RecoverPasswordsController < Web::ApplicationController
  def new
    @recover = RecoverPasswordForm.new
  end

  def create
    @recover = RecoverPasswordForm.new(recover_params)

    if @recover.valid?
      user = @recover.user

      token = SecureRandom.urlsafe_base64
      expire_time = 24.hour.from_now
      user.update!({ reset_token: token, reset_expire: expire_time })

      UserMailer.with({ user: user }).recover_password.deliver_now

      redirect_to(:new_session)
    else
      render(:new)
    end
  end

  def edit
    # форма куда вводить пароли
  end

  def update
    # обновление паролей
  end

  def recover_params
    params.require(:recover_password_form).permit(:email)
  end
end
