set :application, "coursespree"
set :repository, "/git-etutor/coursespree"

after "deploy:symlink", "deploy:update_crontab"

namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{repository} && whenever --update-crontab #{application}"
  end
end
