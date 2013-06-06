set :user, "deploy"
set :domain, "cellove.season.es"
set(:branch) { ENV.fetch('BRANCH', 'staging') }

role :app, domain
role :web, domain
role :db, domain, :primary => true
