# config valid only for current version of Capistrano
lock '3.5'

set :application, 'mercurius'
set :repo_url, 'git@github.com:werthen/mercurius.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
role :web, 'mercurius.werthen.com'
set :deploy_to, '/var/www/mercurius'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

set :user, 'mercurius'

set :use_sudo, false

set :ssh_options, forward_agent: true

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :passenger do
  desc 'Restart Application'
  task :restart do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        execute "touch #{current_path}/tmp/restart.txt"
      end
    end
  end
end

namespace :scraper do
  desc 'Rake scraper:scrape'
  task :scrape do
    on roles(:app) do
      execute "cd #{current_path} && /usr/local/rvm/bin/rvm default do bundle exec rake scraper:scrape RAILS_ENV=#{fetch(:rails_env)}"
    end
  end
end

after :deploy, 'passenger:restart'
