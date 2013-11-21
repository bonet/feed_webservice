require 'coveralls'
Coveralls.wear!

require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rspec'
  require 'database_cleaner'
  
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
  
  RSpec.configure do |config|
    config.mock_with :rspec
    
    #config.use_transactional_fixtures = true
  
    config.infer_base_class_for_anonymous_controllers = false
  
    config.order = "random"
    
    # Include path helpers
    config.include Rails.application.routes.url_helpers
    config.include Capybara::DSL
    
    # Include ability to do :focus in test case
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true
    
    config.before :each do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.start
    end
    
    config.after :each do
      DatabaseCleaner.clean
    end
  end

end

Spork.each_run do
  FactoryGirl.reload
end
