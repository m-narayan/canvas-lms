server "beacon.arrivu.corecloud.com", :app, :web, :db, :primary => true
set :deploy_to, "/var/capistrano/beacon/lms_staging"
set :rails_env, "staging" 
set :branch,    "develop"
set :scm_passphrase, "deployadmin123$"
#set :smart_lms_data_files "/var/capistrano/beacon/lms_staging/data/files"
set :smart_lms_data_files, "#{deploy_to}/data/files"

