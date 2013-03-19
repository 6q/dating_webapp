# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :town, :class => 'Towns' do
    name "MyString"
    longitude 1.5
    latitude 1.5
  end
end
