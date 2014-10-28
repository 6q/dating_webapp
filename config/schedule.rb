env :MAILTO, 'help@cellove.com'

job_type :unicorn_start, 'cd :path && /usr/local/bin/bundle exec unicorn -c :path/config/unicorn/:environment.rb -E :environment -D'

every :reboot do
  unicorn_start 'application'
  #script "cd :path && RAILS_ENV=production script/delayed_job start"
end

# every 24.hours do
#   command "cd :path && RAILS_ENV=production script/delayed_job restart"
# end

every :friday, :at => '13:40pm' do
#every 1.hour do
  runner "User.custom_newsletters"
end

every 30.seconds do
    execute "update users set updated_at='#{DateTime.now.strftime("%Y-%m-%d %H:%M:%S")}' WHERE fake = true AND RAND() < 0.2" 
end