# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = FactoryGirl.create(:regular_user_optin, :admin_role, :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup)
puts 'user: ' << user.name

def create_towns
  puts 'Creating towns...'
  CreateTowns.create_all
end

create_towns

(1..60).each do
  u = FactoryGirl.create(:regular_user_optin)
  receipt = u.send_message(user, Faker::Lorem.paragraphs.join("\n"), Faker::Lorem.sentence)
  user.reply_to_sender(receipt, Faker::Lorem.paragraph)
end

user.mailbox.inbox.sample(5).each { |c| c.move_to_trash(user) }
user.mailbox.sentbox.sample(5).each { |c| c.move_to_trash(user) }

