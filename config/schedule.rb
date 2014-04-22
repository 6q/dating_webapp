env :MAILTO, 'info@quantic.es'

job_type :unicorn_start, 'cd :path && /usr/local/bin/bundle exec unicorn -c :path/config/unicorn/:environment.rb -E :environment -D'

every :reboot do
  unicorn_start 'application'
  #script "cd :path && RAILS_ENV=production script/delayed_job start"
end

# every 24.hours do
#   command "cd :path && RAILS_ENV=production script/delayed_job restart"
# end

# every :thursday, :at => '10am' do
every 10.minutes do
  runner "User.custom_newsletters"
end