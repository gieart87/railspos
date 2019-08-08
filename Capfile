require 'capistrano/setup'
require 'capistrano/deploy'
require	'capistrano/scm/git'
require 'capistrano/nginx'
require 'capistrano/puma'
require 'capistrano/puma/nginx'
require 'capistrano/rvm'
require 'capistrano/rails'
require 'capistrano/rails/db'
require 'capistrano/rails/console'
require 'capistrano/upload-config'
require 'sshkit/sudo'

# install_plugin Capistrano::Nginx
install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Puma  # Default puma tasks
install_plugin Capistrano::Puma::Nginx  # if you want to upload a nginx site template

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }