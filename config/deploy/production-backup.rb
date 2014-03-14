require "rvm/capistrano"
default_run_options[:pty] = true
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
set :web_user, "money_user"
set :web_group, "apache"
set :deploy_to, "/var/www/#{application}"
set :rails_env, :staging

# Phoenix (Backup) Data Center
role :web, "172.23.73.89"     # Your HTTP server, Apache/etc
role :app, "172.23.73.89"     # This may be the same as your `Web` server
role :db,  "172.23.73.89", :primary => true   # This is where Rails migrations will run

set :branch, ENV['BRANCH'] || 'master'


before 'deploy', 'deploy:take_control'
#before 'deploy:symlink_db', 'deploy:delete_rvmrc'
#before 'deploy:assets:precompile', 'deploy:symlink_config_for_staging'
#before 'deploy', 'deploy:set_up_rvm'
after 'deploy', 'deploy:relinquish_control'
# before "deploy:update_code", "deploy:web:disable"
# after "deploy", "deploy:web:enable"
before "deploy:update_git_repo_location", "deploy:take_control"
after "deploy:update_git_repo_location", "deploy:relinquish_control"
before "deploy:set_up_rvm", "deploy:take_control"
after "deploy:set_up_rvm", "deploy:relinquish_control"

namespace :deploy do
  task :take_control do
    sudo "chown -R #{user} #{deploy_to}/", :shell => 'bash', :pty => true
  end

  task :delete_rvmrc, :roles => :app do
    run "rm #{release_path}/.ruby-version"
    run "rm #{release_path}/.ruby-gemset"
  end

  task :symlink_config_for_staging, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/deploy.rb #{release_path}/config/deploy.rb"
  end

  task :relinquish_control do
    sudo "chown -R #{web_user}:#{web_group} #{deploy_to}/", :shell => 'bash', :pty => true
    sudo "chmod -R g+rx #{deploy_to}/", :shell => 'bash', :pty => true
  end

  task :set_up_rvm, :roles => :app do
    rvm.create_gemset
    sudo "chown -R #{web_user} /usr/local/rvm/gems/#{rvm_ruby_string}", :pty => true
  end
end
