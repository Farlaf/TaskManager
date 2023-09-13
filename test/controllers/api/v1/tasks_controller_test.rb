require 'test_helper'

class Api::V1::TasksControllerTest < ActionController::TestCase
  setup do
    @author = create(:user)
    sign_in @author
  end

  test 'should get index' do
    get :index, params: { format: :json }
    assert_response :success
  end

  test 'should get show' do
    task = create(:task, author: @author)
    get :show, params: { id: task.id, format: :json }
    assert_response :success
  end

  test 'should post create' do
    assignee = create(:user)
    task_attributes = attributes_for(:task).
      merge({ assignee_id: assignee.id })

    assert_emails 1 do
      post :create, params: { task: task_attributes, format: :json }
    end
    assert_response :created

    data = JSON.parse(response.body)
    created_task = Task.find(data['task']['id'])

    assert created_task.present?
    assert_equal task_attributes.stringify_keys, created_task.slice(*task_attributes.keys)
  end

  test 'should put update' do
    assignee = create(:user)
    task = create(:task, author: @author)
    task_attributes = attributes_for(:task).
      merge({ author_id: @author.id, assignee_id: assignee.id }).
      stringify_keys

    assert_emails 1 do
      patch :update, params: { id: task.id, format: :json, task: task_attributes }
    end
    assert_response :success

    task.reload
    assert_equal task.slice(*task_attributes.keys), task_attributes
  end

  test 'should delete destroy' do
    task = create(:task, author: @author)

    assert_emails 1 do
      delete :destroy, params: { id: task.id, format: :json }
    end
    assert_response :success

    assert !Task.where(id: task.id).exists?
  end

  test 'shoild put attach_image' do
    task = create(:task, author: @author)

    image = file_fixture('image.jpg')
    attachment_params = {
      image: fixture_file_upload(image, 'image/jpeg'),
      crop_x: 190,
      crop_y: 100,
      crop_width: 300,
      crop_height: 300,
    }

    put :attach_image, params: { id: task.id, attachment: attachment_params, format: :json }
    assert_response :success

    task.reload
    assert { task.image.attached? }
  end

  test 'should put remove_image' do
    task = create(:task, author: @author)

    image = file_fixture('image.jpg')
    attachable_image = fixture_file_upload(image)

    task.image.attach(attachable_image)

    put :remove_image, params: { id: task.id, format: :json }
    assert_response :success

    task.reload
    refute { task.image.attached? }
  end
end
