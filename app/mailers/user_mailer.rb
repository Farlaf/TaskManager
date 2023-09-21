class UserMailer < ApplicationMailer
  def task_created
    user = params[:user]
    @task = params[:task]

    mail(from: 'noreply@taskmanager.com', to: user.email, subject: 'New Task Created')
  end

  def task_updated
    user = params[:user]
    @task = params[:task]

    mail(from: 'noreply@taskmanager.com', to: user.email, subject: 'Task Updated')
  end

  def task_destroy
    user = params[:user]
    @task_id = params[:task_id]

    mail(from: 'noreply@taskmanager.com', to: user.email, subject: 'Task Deleted')
  end

  def recover_password
    @user = params[:user]

    mail(from: 'noreply@taskmanager.com', to: @user.email, subject: 'Recover password')
  end
end
