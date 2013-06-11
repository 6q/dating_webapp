set :user, "deploy"
set :domain, "cellove.season.es"
set(:branch) { ENV.fetch('BRANCH', 'develop') }

role :app, domain
role :web, domain
role :db, domain, :primary => true
