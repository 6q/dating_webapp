set(:rails_env) { stage }
set(:deploy_to) { File.join("", "home", user, "public_html", application) }
set(:application) { "cellove_#{stage}" }

set :use_sudo, false

set :scm, :git
set :repository, "git@github.com:Cellove/cellove.git"
set :deploy_via, :remote_cache
set :keep_releases, 5
set :normalize_asset_timestamps, false

set :shared_children, shared_children + %w(tmp/dragonfly)

# after "deploy", "deploy:cleanup"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy:restart", "deploy:cleanup"
after "deploy:restart", "whenever:update_crontab"
after 'deploy:create_symlink', 'arrowchat:setup'
after 'deploy:create_symlink', 'symlink:app_config'
after 'deploy:restart', 'unicorn:duplicate'

namespace :arrowchat do
  desc "Setup arrowchat folder permissions in the public"
  task :setup, :roles => [:web] do
    ['cache', 'includes', 'includes/functions/integrations', 'cache/data_admin_options.php'].each do |path|
      run "chmod 777 #{current_path}/public/arrowchat/#{path}"
    end

    run "rm -rf #{current_path}/public/arrowchat/install"
  end
end

namespace :symlink do
  desc "Link public directories to shared location."
  task :app_config, :roles => [:web] do
    run "ln -nfs #{shared_path}/config/application.yml #{current_path}/config/application.yml"
  end
end

namespace :whenever do
  task :update_crontab, roles: [:app] do
    run "cd #{current_path} && bundle exec whenever --update-crontab #{application} --set 'path=#{current_path}'"
  end
end
