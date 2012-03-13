set :main_server,           '192.168.3.52'
set :deploy_to,   "/srv/rlb/application/shells"
set :user,        'rlb'
set :create_db_arg,     'finalist'

# Do not modify
# Set up the server
server "#{main_server}", :web, :app, :db, :primary => true
