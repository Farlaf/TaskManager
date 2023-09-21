class SendTaskDestroyNotificationJob < MailerJob
  def perform(user_id, task_id)
    user = User.find_by(id: user_id)
    return if user.blank?

    UserMailer.with({ user: user, task_id: task_id }).task_destroy.deliver_now
  end
end
