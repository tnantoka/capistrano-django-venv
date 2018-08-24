# Capistrano::Django::Venv

## Installation

```ruby
gem 'capistrano-django-venv'
```

## Usage

```
# Capfile
require 'capistrano/django/venv'
```

```
# config/deploy.rb
set :python_path, '~/.pyenv/shims/python'
```
