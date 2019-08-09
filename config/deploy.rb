set :repo_url, 'git@github.com:gieart87/railspos.git'
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :user, 'deployer'
set :application, 'railspos'
set :rails_env, 'production'
server '207.148.71.28', user: "#{fetch(:user)}", roles: %w{app db web}, primary: true
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :pty, true

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/master.key', 'config/puma.rb')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :config_example_suffix, '.example'
set :config_files, %w{config/database.yml config/master.key}
set :puma_conf, "#{shared_path}/config/puma.rb"

namespace :deploy do
  before 'check:linked_files', 'config:push'
  before 'check:linked_files', 'puma:config'
  before 'check:linked_files', 'puma:nginx_config'
  before 'deploy:migrate', 'deploy:db:create'
  after 'deploy:db:create', 'deploy:db:seed'
  after 'puma:smart_restart', 'nginx:restart'
end