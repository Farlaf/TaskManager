FactoryBot.define do
  sequence :string, aliases: [:first_name, :last_name, :password, :name] do |n|
    "string#{n}"
  end
  sequence :email do |n|
    "person#{n}@example.com"
  end
  sequence :avatar do |n|
    "https://placehold.co/140x140?text=avatar_#{n}"
  end
  sequence :text, aliases: [:description] do |n|
    "Lorem #{n} ipsum dolor sit amet consectetur adipisicing elit. A consequuntur officia nobis id."
  end
end
