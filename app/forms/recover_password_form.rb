class RecoverPasswordForm
  include ActiveModel::Model

  attr_accessor(
    :email,
  )

  validates :email, presence: true, format: { with: /\A(.+)@(.+)\z/ }
  validate :user_valid?

  def user
    User.find_by(email: email)
  end

  private

  def user_valid?
    if user.blank?
      errors.add(:email, "email doesn't math")
    end
  end
end
