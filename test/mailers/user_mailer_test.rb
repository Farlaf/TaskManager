require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  setup do
    @user = create(:user)
    @task = create(:task, author: @user)
    @params = { user: @user, task: @task }
  end

  test 'task created' do
    email = UserMailer.with(@params).task_created

    assert_emails 1 do
      email.deliver_later
    end

    assert_equal ['noreply@taskmanager.com'], email.from
    assert_equal [@user.email], email.to
    assert_equal 'New Task Created', email.subject
    assert email.body.to_s.include?("Task #{@task.id} was created")
  end

  test 'task updated' do
    email = UserMailer.with(@params).task_updated

    assert_emails 1 do
      email.deliver_later
    end

    assert_equal ['noreply@taskmanager.com'], email.from
    assert_equal [@user.email], email.to
    assert_equal 'Task Updated', email.subject
    assert email.body.to_s.include?("Task #{@task.id} was updated")
  end

  test 'task destroy' do
    email = UserMailer.with({ user: @user, task_id: @task.id }).task_destroy

    assert_emails 1 do
      email.deliver_later
    end

    assert_equal ['noreply@taskmanager.com'], email.from
    assert_equal [@user.email], email.to
    assert_equal 'Task Deleted', email.subject
    assert email.body.to_s.include?("Task #{@task.id} was deleted")
  end

  test 'should recover password' do
    email = UserMailer.with(@params).recover_password

    assert_emails 1 do
      email.deliver_later
    end

    assert_equal ['noreply@taskmanager.com'], email.from
    assert_equal [@user.email], email.to
    assert_equal 'Recover password', email.subject
    assert email.body.to_s.include?('Link to recover password (set new)')
  end
end
