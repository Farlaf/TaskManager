require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'create' do
    task = create(:task)
    assert task.persisted?
  end
end
