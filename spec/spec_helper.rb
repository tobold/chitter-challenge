ENV['RACK_ENV'] = 'test'

require 'simplecov'
require 'simplecov-console'
require 'database_cleaner'
require 'capybara/rspec'
require './app/app'

require './spec/features/web_helpers.rb'

Capybara.app = Chitter

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::Console,])
SimpleCov.start

DataMapper.auto_migrate!

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
DatabaseCleaner.clean
  end

  config.after(:suite) do

  end
end
