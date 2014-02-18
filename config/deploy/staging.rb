set :user, "cellove"
set :domain, "cellove.quantic.es"
set(:branch) { ENV.fetch('BRANCH', 'develop') }

role :app, domain
role :web, domain
role :db, domain, :primary => true

ssh_options[:port] = 2273

require 'capistrano-unicorn'
