#set :application, "hidden-reef-7837"
#set :repository, "/projects/hidden-reef-7837"
#
#after "deploy:symlink", "deploy:update_crontab"
#
#namespace :deploy do
#  desc "Update the crontab file"
#  task :update_crontab, :roles => :db do
#    run "cd #{release_path} && whenever --update-crontab #{application}"
#  end
#end
