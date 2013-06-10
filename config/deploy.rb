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

after 'deploy:create_symlink', 'arrowchat:setup'
after 'deploy:create_symlink', 'symlink:app_config'

namespace :arrowchat do
  desc "Setup arrowchat folder permissions in the public"
  task :setup, :roles => [:web] do
    ['cache', 'includes', 'includes/functions/integrations'].each do |path|
      run "chmod 777 #{current_path}/public/arrowchat/#{path}"
    end
  end
end

namespace :symlink do
  desc "Link public directories to shared location."
  task :app_config, :roles => [:web] do
    run "ln -nfs #{shared_path}/config/application.yml #{current_path}/config/application.yml"
  end
end
