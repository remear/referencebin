ARGV.each do|a|
  puts "Argument: #{a}"
end

set :application, "prb"
set :repository,  "git@reanstudios.com:prb"
set :scm, :git
set :git_shallow_clone, 1
set :scm_verbose, true

set :use_sudo, false
set :ssh_options, {:forward_agent => true}
ssh_options[:forward_agent] = true
#on :start do    
#  `ssh-add`
#end


task :edge do
  role :web, "edge.reanstudios.org"
  role :app, "edge.reanstudios.org"
  role :db,  "edge.reanstudios.org", :primary => true # This is where Rails migrations will run
  set :deploy_to, "/Library/rails/#{application}-edge"

  set :keep_releases, 5
  #set :branch, "#{br}"
end

task :live do
  role :web, "reanstudios.org"
  role :app, "reanstudios.org"
  role :db,  "reanstudios.org", :primary => true # This is where Rails migrations will run
  set :deploy_to, "/Library/rails/#{application}"
  
  set :keep_releases, 3
  #set :branch, "#{ARGV[2]}"
  
  puts "****DEPLOYING LIVE****"
end



#restart passenger process
namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

#create symlinks for assets and configs
after 'deploy:symlink', :roles => :app do
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{current_path}/config/database.yml"
  run "ln -nfs #{deploy_to}/#{shared_dir}/system/assets #{current_path}/public/assets"
end

#after 'deploy:symlink', :roles => :app do
#  run "sudo rake gems:install"
#end

#cleanup old releases
after "deploy", "deploy:cleanup"