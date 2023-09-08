# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def task_created
    UserMailer.with(mail_info).task_created
  end

  def task_updated
    UserMailer.with(mail_info).task_updated
  end

  def task_deleted
    UserMailer.with(mail_info).task_destroy
  end

  def recover_password
    UserMailer.with({ user: User.first }).recover_password
  end

  private

  def mail_info
    user = User.first
    task = Task.first

    { user: user, task: task }
  end
end
