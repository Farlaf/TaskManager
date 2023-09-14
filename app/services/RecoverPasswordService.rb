module RecoverPasswordService
  class << self
    def create_reset_token!(user)
      token = SecureRandom.urlsafe_base64
      user.update!({ reset_token: token, reset_expire: 24.hour.from_now })
    end

    def token_invalid?(user)
      user.reset_expire < Time.now
    end

    def set_password!(user, password)
      user.update!({
                     password: password,
                     reset_token: nil,
                     reset_expire: nil,
                   })
    end
  end
end
