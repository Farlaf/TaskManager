class User < ApplicationRecord
  has_secure_password

  has_many :my_tasks, class_name: 'Task', foreign_key: :author_id
  has_many :assigned_tasks, class_name: 'Task', foreign_key: :assignee_id

  validates :first_name, :last_name, :email, presence: true
  validates :first_name, :last_name, length: { minimum: 2 }
  validates :email, format: { with: /\A(.+)@(.+)\z/ }
  validates :email, uniqueness: true

  def self.ransackable_attributes(_auth_object = nil)
    ['avatar', 'created_at', 'email', 'first_name', 'id', 'last_name', 'type', 'updated_at']
  end

  def self.ransackable_associations(_auth_object = nil)
    ['assigned_tasks', 'my_tasks']
  end
end
