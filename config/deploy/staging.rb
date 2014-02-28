set :user, "deploy"
set :domain, "staging.cellove.com"
set(:branch) { ENV.fetch('BRANCH', 'develop') }

role :app, domain
role :web, domain
role :db, domain, :primary => true

ssh_options[:port] = 22

require 'capistrano-unicorn'
