# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'ktc.hn'
set :repo_url, 'git@github.com:kitchen/ktchn'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('tmp')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

before 'deploy', 'rvm1:install:rvm'
before 'deploy', 'rvm1:install:ruby'
before 'deploy', 'rvm1:install:gems'
before 'deploy', 'rvm1:alias:create'
set :rvm1_alias_name, 'ktchn'
set :rvm1_ruby_version, '2.2'

namespace 'ktchn' do
  namespace 'deploy' do
    task :restart do
      on roles(:app) do
        execute :touch, release_path.join('tmp/restart.txt')
      end
    end
  end
end
after 'deploy:publishing', 'ktchn:deploy:restart'

namespace 'ktchn' do
  namespace 'rvm1' do
    task :disable_autolibs do
      on roles(fetch(:rvm1_roles, :all)) do
        within fetch(:release_path) do
          execute :rvm, 'autolibs', 'disable'
        end
      end
    end
  end
end
before 'rvm1:install:ruby', 'ktchn:rvm1:disable_autolibs'
