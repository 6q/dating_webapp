# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recommendation do
    user_id 1
    creator_id 1
    relationship "MyString"
    description "MyString"
  end
end
