require 'capistrano/setup'
require 'capistrano/deploy'
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git
require 'capistrano/nginx'
require 'capistrano/puma'
require 'capistrano/puma/nginx'
require 'capistrano/rvm'
require 'capistrano/rails'
require 'capistrano/rails/db'
require 'capistrano/rails/console'
require 'capistrano/upload-config'
require 'sshkit/sudo'
install_plugin Capistrano::Puma

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }