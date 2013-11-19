set :application, "gann"
set :repository,  "https://github.com/andrewsong90/GAN.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/home/gannacademy/webapps/gann"

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
		run "cd #{deploy_to}"
		run "export GEM_HOME=$PWD/gems"
		run "export RUBYLIB=$PWD/lib"
		run "export PATH=$PWD/bin:$PATH"
		#run "gem install bundler"
	end
end


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