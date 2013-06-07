set(:rails_env) { stage }
set(:deploy_to) { File.join("", "home", user, "public_html", application) }
set(:application) { "cellove_#{stage}" }

set :use_sudo, false

set :scm, :git
set :repository, "git@git.season.es:cellove.git"
set :deploy_via, :remote_cache
set :keep_releases, 3
set :normalize_asset_timestamps, false

set :shared_children, shared_children + %w(tmp/dragonfly)

# after "deploy", "deploy:cleanup"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{shared_path}/pids/unicorn.pid`"
  end
end
