class SendTaskUpdateNotificationJob < MailerJob
  def perform(task_id)
    task = Task.find(task_id)
    return if task.blank?

    UserMailer.with(user: task.author, task: task).task_updated.deliver_now
  end
end
