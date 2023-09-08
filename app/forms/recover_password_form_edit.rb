class RecoverPasswordFormEdit
  include ActiveModel::Model

  attr_accessor(
    :password,
    :password_confirmation,
  )

  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
end
