FactoryBot.define do
  factory :vertical do
    name { Faker::Internet.user_name }
  end
end
