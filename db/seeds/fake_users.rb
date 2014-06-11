puts 'Creating users...'

#Create men
300.times do |n|
  name = Faker::Name.first_male_name
  username = "#{Faker::Internet.user_name(name)}_#{n}"
  u = FactoryGirl.create(:regular_user_optin, name: name, seeking: User::SEEKING.keys.first, email: Faker::Internet.email(username))
  u.create_general_settings({})
  Characteristic.create(user_id: u.id, creator_id: u.id)
end

#Create women
300.times do |n|
  name = Faker::Name.first_female_name
  username = "#{Faker::Internet.user_name(name)}_#{n}"
  u = FactoryGirl.create(:regular_user_optin, name: name, seeking: User::SEEKING.keys[1], email: Faker::Internet.email(username))
  u.create_general_settings({})
  Characteristic.create(user_id: u.id, creator_id: u.id)
end
