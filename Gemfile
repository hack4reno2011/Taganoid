source 'http://rubygems.org'

gem 'rails', '3.1.10'
gem 'jquery-rails'
gem 'haml'
gem 'pg'

# asset pipeline
group :assets do
  gem 'sass-rails'
  gem 'uglifier'
  gem 'execjs'
  gem 'therubyracer', '~> 0.10.2', :require => 'v8'   # until we have RHEL6 servers w/gcc4.4+, latest v8 won't compile
end

gem 'ransack'
gem 'will_paginate'

gem 'capistrano'
gem 'factory_girl_rails'
gem 'exception_notification', :require => 'exception_notifier'

gem 'paperclip'
gem 'aws-s3',
    :require => 'aws/s3'

### background processing
gem 'resque'
gem 'delayed_paperclip'

group :development, :test do
  gem 'awesome_print'
  gem 'silent-postgres'
  gem 'nifty-generators'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'linecache19'
  gem 'rspec-rails'
  gem 'autotest'
  gem 'mocha'
  gem 'simplecov', :require => false

  ### deployment
  gem 'heroku'

  ### documentation
  gem 'rails-erd'
end
