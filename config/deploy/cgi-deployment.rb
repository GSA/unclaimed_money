require "rvm/capistrano"
set :rvm_ruby_string, 'ruby-1.9.3-p484@unclaimed_money'
set :rvm_type, :system                   # Defaults to: :auto
set :bundle_cmd, "/usr/local/rvm/gems/ruby-1.9.3-p484@global/bin/bundle"
set :bundle_dir, ''
set :bundle_flags, '--system --quiet'
#set :bundle_dir, "/usr/local/rvm/gems/ruby-1.9.3-p484"
#set :rvm_ruby_version, '1.9.3-p484'      # Defaults to: 'default'

# Use this if you're stuck behind a draconian VPN
set :use_sudo, true
set(:real_revision) { source.query_revision( revision ) { |cmd| capture(cmd) } }
set :user, ENV['USER'] || 'apache'
set :web_user, "apache"
set :web_group, "apache"
set :deploy_to, "/var/www/#{application}"
set :domain, "172.22.79.89"
set :rails_env, :staging

role :web, "#{domain}"                          # Your HTTP server, Apache/etc
role :app, "#{domain}"                          # This may be the same as your `Web` server
role :db,  "#{domain}", :primary => true        # This is where Rails migrations will run

set :branch, ENV['BRANCH'] || 'master'


before 'deploy', 'deploy:take_control'
#before 'deploy:symlink_db', 'deploy:delete_rvmrc'
#before 'deploy:assets:precompile', 'deploy:symlink_config_for_staging'
after 'deploy', 'deploy:relinquish_control'
# before "deploy:update_code", "deploy:web:disable"
# after "deploy", "deploy:web:enable"

namespace :deploy do
  task :take_control do
    sudo "chown -R #{user} #{deploy_to}/", :pty => true
  end

  task :delete_rvmrc, :roles => :app do
    run "rm #{release_path}/.ruby-version"
    run "rm #{release_path}/.ruby-gemset"
  end

  task :symlink_config_for_staging, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/deploy.rb #{release_path}/config/deploy.rb"
  end

  task :relinquish_control do
    sudo "chown -R #{web_user}:#{web_group} #{deploy_to}/", :pty => true
    sudo "chmod -R g+rx #{deploy_to}/", :pty => true
  end
end
