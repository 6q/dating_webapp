require 'faker'

FactoryGirl.define do
  factory :_user do #_because I don't want it to be used directly
    trait :basic_data do
      name{ Faker::Name.first_name }
      surname{ Faker::Name.last_name }
      email{ Faker::Internet.email }
      password "V3RYS3CUR3"
    end

    trait :complementary_data do
      town{ Faker::Address.city }
      country{ Faker::Address.country }
      zip_code{ Faker::Address.zip_code }
      screen_name{ [name, surname].join.underscore }
      marital_status{ User::MARITAL_STATUS.sample }
      orientation{ User::ORIENTATION.sample }
      gender{ User::GENDER.sample }
      birth_date{ Date.today << ((rand(10) + 18) * 12) }
      terms_and_conditions "1"
    end

    trait :optional_data do
      newsletter_optin true
    end

    factory :regular_user, traits: [:basic_data, :complementary_data]
    factory :regular_user_optin, traits: [:basic_data, :complementary_data]
    factory :matchmaker, traits: [:basic_data]
    factory :matchmaker_optin, traits: [:basic_data, :optional_data]
  end
end
