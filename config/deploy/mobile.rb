set :user, "deploy"
set :domain, "mobile.cellove.com"
set(:branch) { ENV.fetch('BRANCH', 'mobile') }
set :stage, "mobile"

role :app, domain
role :web, domain
role :db, domain, :primary => true

ssh_options[:port] = 22

require 'capistrano-unicorn'

set :whenever_environment, defer { stage }
set :whenever_identifier, defer { "#{application}_#{stage}" }
require "whenever/capistrano"