# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_mailing do
    user nil
    sent_user_id 1
  end
end
