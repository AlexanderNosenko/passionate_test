FactoryBot.define do
  factory :course do
    name { "#{Faker::Movies::HarryPotter.spell}ology" }
    author { Faker::Name.name }
    category { Category.last }
    state { 'active' }
  end
end
