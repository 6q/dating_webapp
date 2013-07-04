set :user, "deploy"
set :domain, "www.cellove.com"
set(:branch) { ENV.fetch('BRANCH', 'develop') }

role :app, domain
role :web, domain
role :db, domain, :primary => true
