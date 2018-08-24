require "capistrano/django/venv/version"

namespace :django do
  task :venv do
    on roles(:all) do |_|
      execute "cd #{shared_path} && #{fetch(:python_path, '~/.pyenv/shims/python')} -m venv venv" 
    end
  end

  task :bundle do
    on roles(:all) do |_|
      execute "#{release_path}/venv/bin/pip install -r #{release_path}/requirements.txt"
    end
  end

  task :migrate do
    on roles(:all) do |_|
      execute "#{release_path}/venv/bin/python #{release_path}/#{fetch(:project)}/manage.py migrate"
    end
  end

  task :assets do
    on roles(:all) do |__|
        execute "yes yes | #{release_path}/venv/bin/python #{release_path}/#{fetch(:project)}/manage.py collectstatic"
    end
  end
end

after 'deploy:updated', 'django:venv'
after 'deploy:updated', 'django:bundle'
after 'deploy:updated', 'django:migrate'
after 'deploy:updated', 'django:assets'
