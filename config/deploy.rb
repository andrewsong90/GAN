require 'delayed/recipes'
require 'bundler/capistrano'

set :application, "gann"
set :repository,  "https://github.com/andrewsong90/GAN.git"
set :branch, "master"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`


set :delayed_job_command, "bin/delayed_job"


set :keep_releases, 5

set :deploy_to, "/home/gannacademy/webapps/gann"

set :shared_children, shared_children+%w{uploads user_uploads}

set :rails_env, "production"

set :default_stage, "production"

set :default_environment, {
	'PATH' => "#{deploy_to}/bin:$PATH",
	'GEM_HOME' => "#{deploy_to}/gems",
	'RUBYLIB' => "#{deploy_to}/lib"
}

role :web, "web430.webfaction.com"                          # Your HTTP server, Apache/etc
role :app, "web430.webfaction.com"                          # This may be the same as your `Web` server
role :db,  "web430.webfaction.com", :primary => true # This is where Rails migrations will run

set :user, "gannacademy"
set :scm_username, "andrewsong90"
set :use_sudo, false
default_run_options[:pty] = true

namespace :deploy do
	desc "Restarting nginx"
	task :restart do
		run "#{deploy_to}/bin/restart"
		#run "gem install bundler"
	end

	desc "Symlink shared configs and folders on each release."
	task :symlink_shared do
		run "ln -nfs #{shared_path}/application.yml #{release_path}/config/application.yml"
		run "ln -nfs #{shared_path}/production.rb #{release_path}/config/environments/production.rb"
		#run "cp -f #{shared_path}/config/application.yml #{release_path}/config/application.yml"
	end

	desc "Set environment_variables"
	task :default_vars do
		run "export PATH=#{deploy_to}/bin:$PATH"
		run "export GEM_HOME=#{deploy_to}/gems"
		run "export RUBYLIB=#{deploy_to}/lib"
	end
end

after 'deploy:update_code', 'deploy:symlink_shared'

# after "deploy", "deploy:restart"

# after "deploy:start", "delayed_job:start"
# after "deploy:stop", "delayed_job:stop"
# after "deploy:restart", "delayed_job:stop", "delayed_job:start"


# after "deploy", "deploy:migrate"


# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end