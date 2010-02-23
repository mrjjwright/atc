load 'deploy'
 
set :webfaction_username, "atc"
set :webfaction_db_type, "mysql"
set :webfaction_db, "atc"
set :webfaction_db_username, "atc"
set :webfaction_port, "53193"
set :database_yml_template, "database.example.yml"
 
set :application, "rails"
set :deploy_to, "/home/#{webfaction_username}/webapps-releases/#{application}"
 
set :scm, :git
set :repository, "git@github.com:mrjjwright/atc.git"
set :git_shallow_clone, 1
set :short_branch, "master"
set :user, "#{webfaction_username}"
set :use_sudo, false 
 
set :domain, "atc.webfactional.com"
 
role :app, domain
role :web, domain
role :db,  domain, :primary => true
 
desc "Symlink public to what webfaction expects the webroot to be"
task :after_symlink, :roles => :web do
  #copy over uploaded files to the new releases
  run "mkdir #{release_path}/public/uploads"
  run "cp -R /home/#{webfaction_username}/webapps/#{application}/public/uploads #{release_path}/public/"
  run "ln -nfs #{release_path}/public /home/#{webfaction_username}/webapps/#{application}/"
end
 
default_environment["PATH"] = "/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/home/#{webfaction_username}/bin:/home/#{webfaction_username}/.gem/ruby/1.8/bin"
default_environment["GEM_PATH"] = "/home/#{webfaction_username}/ruby1.8/lib/ruby/gems/1.8/gems"


namespace :deploy do
 
  # Taken from http://jonathan.tron.name/2006/07/15/capistrano-password-prompt-tips 
  # Thanks Jonathan! :)
  desc "Creates the database configuration on the fly"
  task :create_database_configuration, :roles => :app do
    require "yaml"
    set :production_db_password, proc { Capistrano::CLI.password_prompt("Remote production database password: ") }
 
    db_config = YAML::load_file("config/#{database_yml_template}")
    db_config.delete('test')
    db_config.delete('development')
 
    db_config['production']['adapter'] = "#{webfaction_db_type}"
    db_config['production']['database'] = "#{webfaction_db}"
    db_config['production']['username'] = "#{webfaction_db_username}"
    db_config['production']['password'] = production_db_password
    db_config['production']['host'] = "localhost"
 
    put YAML::dump(db_config), "#{release_path}/config/database.yml", :mode => 0664
  end
 
  after "deploy:update_code", "deploy:create_database_configuration"
 
  desc "Redefine deploy:start"
  task :start, :roles => :app do
    invoke_command "/usr/local/bin/mongrel_rails start -c #{deploy_to}/current -d -e production  -l /home/#{webfaction_username}/webapps/#{application}/log/mongrel.log -P /home/#{webfaction_username}/webapps/#{application}/log/mongrel.pid -p #{webfaction_port}", :via => run_method
  end
 
  desc "Redefine deploy:restart"
  task :restart, :roles => :app do
    invoke_command "/usr/local/bin/mongrel_rails restart -c #{deploy_to}/current   -P /home/#{webfaction_username}/webapps/#{application}/log/mongrel.pid", :via => run_method
  end
 
  desc "Redefine deploy:stop"
  task :stop, :roles => :app do
    invoke_command "/usr/local/bin/mongrel_rails stop -c #{deploy_to}/current  -P /home/#{webfaction_username}/webapps/#{application}/log/mongrel.pid", :via => run_method
  end
end