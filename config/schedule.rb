env :MAILTO, 'info@quantic.es'

job_type :unicorn_start, 'cd :path && /usr/local/bin/bundle exec unicorn -c :path/config/unicorn/:environment.rb -E :environment -D'

every :reboot do
  unicorn_start 'application'
end
