set :user, "deploy"
set :domain, "staging.cellove.com"
set(:branch) { ENV.fetch('BRANCH', 'develop') }
set :stage, "staging"

role :app, domain
role :web, domain
role :db, domain, :primary => true

ssh_options[:port] = 22

require 'capistrano-unicorn'

set :whenever_environment, defer { stage }
set :whenever_identifier, defer { "#{application}_#{stage}" }
require "whenever/capistrano"