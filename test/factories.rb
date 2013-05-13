require 'faker'

FactoryGirl.define do
  factory :_user do # '_' because I don't want it to be used directly
    trait :basic_data do
      name{ Faker::Name.first_name }
      surname{ Faker::Name.last_name }
      screen_name{ [name, surname].join.underscore }
      email{ Faker::Internet.email }
      password "V3RYS3CUR3"
    end

    trait :complementary_data do
      town{ Faker::Address.city }
      country{ Faker::Address.country }
      postal_code{ Faker::Address.zip_code }
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

    # This trait does not work for some reason.
    #trait :has_recommendations do
    #  after(:create) do |user, evaluator|
    #    create_list(:recommendation, evaluator.recommendations_count, user: user)
    #  end
    #end

    trait :with_recommendations do
      recommendations { [create(:recommendation, user_id: 1, creator_id: 2)] }
    end

    trait :with_recommenders do
      recommenders { [create(:recommendation, user_id: 1, creator_id: 2)] }
    end

    ignore do
      picture_count 1
      recommendations_count 1
    end

    factory :regular_user, traits: [:basic_data, :complementary_data, :user_role]
    factory :regular_user_optin, traits: [:basic_data, :complementary_data, :optional_data, :user_role]
    factory :regular_user_with_recommenders, traits: [:basic_data, :complementary_data, :user_role, :with_recommenders]
    factory :matchmaker, traits: [:basic_data, :matchmaker_role]
    factory :matchmaker_optin, traits: [:basic_data, :optional_data, :matchmaker_role]
    factory :matchmaker_with_picture, traits: [:basic_data, :picture, :matchmaker_role]
    factory :matchmaker_with_recommendations, traits: [:basic_data, :matchmaker_role, :with_recommendations]
    factory :regular_user_with_picture, traits: [:basic_data, :complementary_data, :picture, :user_role]
  end

  factory :recommendation do
    relationship 1
    description "A very kind and handsome guy."

    factory :invalid_recommendation do
      relationship nil
    end
  end

  factory :characteristic do
    romantic 3
    friendly 3
    familiar 3
    hardWorking 3
    extroverted 3
    generous 3
    reserved 3
    sociable 3
    quiet 3
    demanding 3
    prideful 3
    solitary 3
    tenacious 3
    attentive 3
    goodHumored 3
    spontaneous 3
    restless 3
    sensitive 3
    shy 3
    possessive 3
    jealous 3
    faithful 3
  end

  factory :male_picture, class: Picture do
    image_url { FAKE_PICTURES::HEADSHOTS::MEN.sample }
  end

  factory :female_picture, class: Picture do
    image_url { FAKE_PICTURES::HEADSHOTS::WOMEN.sample }
  end
end
