FactoryBot.define do
  factory :category do
    name { Faker::ProgrammingLanguage.name }
    vertical { Vertical.first }
    state { 'active' }
  end
end
