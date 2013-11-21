source 'https://rubygems.org'

ruby "2.0.0"

gem 'rails', '3.2.12'

gem 'rake'
gem "mongoid", "~> 3.0.0"
gem "bson_ext"
gem "cocaine"
gem 'nokogiri' 
gem 'jquery-rails'
gem 'aws-sdk'

gem 'thin'

gem 'coveralls', require: false

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do

  
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'
  gem 'colorize'

  gem 'rb-fchange', :require => false
  gem 'rb-fsevent', '~> 0.9.2'
  gem 'rb-inotify', :require => false
  gem 'rb-readline', :require => false
end


group :development, :test do
  gem 'figaro'
  
  gem 'rspec-rails'
  
  gem 'mongoid-rspec'
  
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-spork'
  
  gem 'factory_girl_rails'

  gem 'simplecov'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  #gem 'terminal-notifier-guard' # OSX 10.8
  gem 'mailcatcher'
  gem 'zeus' 
end
