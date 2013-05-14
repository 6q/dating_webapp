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
      postal_code{ Faker::Address.zip_code }
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

    trait :user_role do
      after(:create) do |user|
        user.add_role :user
      end
    end
    
    trait :matchmaker_role do
      after(:create) do |user|
        user.add_role :matchmaker
      end
    end

    trait :admin_role do
      after(:create) do |user|
        user.add_role :admin
      end
    end

    trait :picture do
      after(:create) do |user, evaluator|
        if user.gender == 'male'
          FactoryGirl.create_list(:male_picture, evaluator.picture_count, attachable: user)
        else
          FactoryGirl.create_list(:female_picture, evaluator.picture_count, attachable: user)
        end
      end
    end

    ignore do
      picture_count 1
    end

    factory :regular_user, traits: [:basic_data, :complementary_data, :user_role]
    factory :regular_user_optin, traits: [:basic_data, :complementary_data, :optional_data, :user_role]
    factory :matchmaker, traits: [:basic_data, :matchmaker_role]
    factory :matchmaker_optin, traits: [:basic_data, :optional_data, :matchmaker_role]
    factory :matchmaker_with_picture, traits: [:basic_data, :picture, :matchmaker_role]
    factory :regular_user_with_picture, traits: [:basic_data, :complementary_data, :picture, :user_role]
  end

  factory :male_picture, class: Picture do
    image_url { FAKE_PICTURES::HEADSHOTS::MEN.sample }
  end

  factory :female_picture, class: Picture do
    image_url { FAKE_PICTURES::HEADSHOTS::WOMEN.sample }
  end

  factory :activity do
    activity_type :cofee
    body 'Activity body'
    date Date.today + 20.days
    status :accepted
  end
  
end
