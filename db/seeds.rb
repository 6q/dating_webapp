puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = FactoryGirl.create(:regular_user_optin, :admin_role, :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup)
Characteristic.create(user_id: user.id, creator_id: user.id)
user.create_general_settings({})
puts 'user: ' << user.name

def create_geo
  puts 'Loading geo info...'
  base_dir = Rails.root.join('db', 'data')

  bulk_load = [City, Region]

  bulk_load.each do |table|
    if table.first.nil? # only bulk load into empty tables
      f = File.new "#{base_dir}/#{table.table_name}.sql"

      while statements = f.gets("") do
        ActiveRecord::Base.connection.execute(statements)
      end
    end
  end
end

create_geo

puts 'Creating users...'
60.times do |n|
  name = Faker::Name.first_female_name
  username = "#{Faker::Internet.user_name(name)}_#{n}"
  u = FactoryGirl.create(:regular_user_optin, name: name, seeking: User::SEEKING.keys[1], email: Faker::Internet.email(username))
  receipt = u.send_message(user, Faker::Lorem.paragraphs.join("\n"), Faker::Lorem.sentence)
  user.reply_to_sender(receipt, Faker::Lorem.paragraph)
  u.create_general_settings({})
  Characteristic.create(user_id: u.id, creator_id: u.id)
end

user.mailbox.inbox.sample(5).each { |c| c.move_to_trash(user) }
user.mailbox.sentbox.sample(5).each { |c| c.move_to_trash(user) }

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
