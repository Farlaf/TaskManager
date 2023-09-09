module RecoverPasswordsHelper
  def get_user
    @user = User.find_by(reset_token: params[:token])
    return @user if @user.present?

    flash[:notice] = 'user not found'
    redirect_to(root_url)
  end

  def token_correct?
    unless @user.reset_expire > Time.now
      flash[:notice] = 'incorrect token'
      redirect_to(new_recover_passwords_path)
    end
  end
end
