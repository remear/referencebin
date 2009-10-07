set :application, "prb"
set :repository,  "git@reanstudios.com:prb"
set :deploy_to, "/Library/rails/#{application}"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
set :use_sudo, false
set :ssh_options, {:forward_agent => true}
on :start do    
  `ssh-add`
end

role :web, "reanstudios.com"                          # Your HTTP server, Apache/etc
role :app, "reanstudios.com"                          # This may be the same as your `Web` server
role :db,  "reanstudios.com", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  #task :start {}
  #task :stop {}
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after 'deploy:symlink', :roles => :app do
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{current_path}/config/database.yml"
  run "ln -nfs #{deploy_to}/#{shared_dir}/system/assets #{current_path}/public/assets"
end