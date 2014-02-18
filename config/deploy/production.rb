# Use this if you're stuck behind a draconian VPN
set(:real_revision) { source.query_revision( revision ) { |cmd| capture(cmd) } }
set :user, ENV['USER'] || 'ubuntu'
set :web_user, "mygov"
set :web_group, "apache"
set :deploy_to, "/var/www/#{application}"
set :domain, "" # TBD
set :rails_env, :staging

role :web, "#{domain}"                          # Your HTTP server, Apache/etc
role :app, "#{domain}"                          # This may be the same as your `Web` server
role :db,  "#{domain}", :primary => true        # This is where Rails migrations will run

set :branch, ENV['BRANCH'] || 'master'


before 'deploy', 'deploy:take_control'
before 'deploy:symlink_db', 'deploy:delete_rvmrc'
before 'deploy:assets:precompile', 'deploy:symlink_config_for_staging'
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
