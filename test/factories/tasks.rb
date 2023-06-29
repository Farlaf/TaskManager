FactoryBot.define do
  factory :task do
    name
    description
    author factory: :manager
    assignee factory: :developer
  end
end
