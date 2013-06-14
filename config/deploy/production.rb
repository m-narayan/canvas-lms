server "lms.beaconlaerning.com", :app, :web, :db, :primary => true
set :deploy_to, "/var/capistrano/beacon/lms"
set :branch,    "production"
set :scm_passphrase, "deployadmin123$"
set :smart_lms_data_files, "#{deploy_to}/data/files"
