source 'http://rubygems.org'

gem 'rails', '3.0.4'
gem 'pg'
gem 'haml-rails'
gem 'compass'
gem 'jquery-rails'
gem 'inherited_resources'
gem 'redis'
gem 'httparty'

group :test do
  gem 'miniskirt', :git => 'git://github.com/hoverlover/miniskirt.git', :branch => 'gem'
  gem 'ffaker'
  gem 'capybara', '0.4.0'
  gem 'ruby-debug19'
  gem 'rr'
end

group :production do
  gem 'hassle', :git => 'git://github.com/koppen/hassle.git'
end

group :development do
  gem 'heroku'
  gem 'watchr'
  gem 'spork', '>=0.9.0.rc2'
  gem 'guard'
  gem 'guard-spork'
  gem 'guard-bundler'
  gem 'rb-fsevent'
  gem 'growl'
end

group :test, :development do
  gem 'awesome_print', :require => 'ap'
  gem "rspec-rails", "~> 2.5"
  gem 'steak'
  gem 'shoulda-matchers'
end
