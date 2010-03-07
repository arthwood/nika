set :deploy_to, '/home/arthwood/www/nika'
set :rails_env, 'production'
set :deploy_via, :remote_cache
set :repository, 'git@github.com:arthwood/nika.git'
set :scm, :git
set :git_enable_submodules, 1
set :keep_releases, 3
set :use_sudo, false

server "arthwood@arthwood.megiteam.pl", :app, :web, :db, :primary => true

after "deploy:update_code", "deploy:setup_symlinks"

SHARED_FILES = %w(config/database.yml config/initializers/local_config.rb)

namespace :deploy do
  desc "starts application server(s)"
  task :start do
    run "restart-app nika"
  end
  
  desc "restarts application server(s)"
  task :restart do
    run "restart-app nika"
  end

  desc "Links shared files (e.g. with uploaded files) to current"
  task :setup_symlinks do
    SHARED_FILES.each do |path|
      run "ln -nfs #{shared_path}/#{path} #{release_path}/#{path}"
    end
  end
end
