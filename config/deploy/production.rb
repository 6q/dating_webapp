set :user, "deploy"
set :domain, "88.198.45.199"
set(:branch) { ENV.fetch('BRANCH', 'master') }

role :app, domain
role :web, domain
role :db, domain, :primary => true

require 'capistrano-unicorn'
