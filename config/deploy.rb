# Enable multi-stage support
require 'capistrano/ext/multistage'

# Stage definitions
set :stages,        %w(testing acceptance)
set :default_stage, "testing"

# Deployment environment information
set :application, "nfcb_shells"
set :repository,  "git@github.com:finalist/nfcb_shells.git"
set :scm, :git
set :deploy_via,  :copy

set :ssh_options, :forward_agent => true

set :use_sudo, false
set :keep_releases, 10

# For Explanation: http://www.mail-archive.com/capistrano@googlegroups.com/msg02817.html
default_run_options[:pty] = true

namespace :config do
  desc "Add stage specific overrides to the conf/application.conf"
  task :add_stage_specific_configuration do
    run "cat #{release_path}/conf/application.conf.#{stage} >> #{release_path}/conf/application.conf"
  end
end

namespace :symlink do
  desc "Symlink logs directory"
  task :logs do
    run "ln -sf #{shared_path}/log #{release_path}/logs"
  end
end

namespace :restart do
  desc "Restart the Play! application"
  task :restart_the_play_application do
    run "#{release_path}/db/scripts/createDB.sh #{create_db_arg} #{release_path}/db/scripts writecompletionscript 2>&1 | tee #{release_path}/log/restart.log"
    run "#{release_path}/play_no_su.sh stop 2>&1 | tee -a #{release_path}/log/restart.log"
    run "#{release_path}/db/tmp/createdb.success.sh 2>&1 | tee -a #{release_path}/log/restart.log"
    run "/usr/bin/nohup #{release_path}/play_no_su.sh start"
  end
end

after 'deploy:update_code',     'config:add_stage_specific_configuration'
after 'deploy:update_code',     'symlink:logs'
after 'deploy:restart',         'restart:restart_the_play_application'
