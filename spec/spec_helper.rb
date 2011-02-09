require 'rubygems'
require 'spork'

ENV["RAILS_ENV"] = 'test'

Spork.prefork do
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'miniskirt'
  require 'spork/ext/ruby-debug'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rr
    config.use_transactional_fixtures = true
    config.include ActionView::Helpers::TranslationHelper
  end

  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
end

Spork.each_run do
  # This code will be run each time you run your specs.
  require 'factories'

  RSpec.configure do |config|
    config.include Rails.application.routes.url_helpers, :type => :acceptance
  end
end

