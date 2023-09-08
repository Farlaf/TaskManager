class Web::RecoverPasswordsController < Web::ApplicationController
  def new
    @recover = RecoverPasswordForm.new
  end

  def create
    @recover = RecoverPasswordForm.new(recover_params)

    if @recover.valid?
      user = User.find_by(email: @recover.email)
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
