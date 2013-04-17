# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    surname: Faker::Name.name
    password '12345'
    confirm_password '12345'
    screen_name: Faker::Internet.user_name
  end
end
