set :user, "deploy"
set :domain, "production.cellove.com"
set(:branch) { ENV.fetch('BRANCH', 'master') }

role :app, domain
role :web, domain
role :db, domain, :primary => true

require 'capistrano-unicorn'
