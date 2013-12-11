ENV['RACK_ENV'] = 'test'

require 'bundler/setup'
require File.expand_path('../../lib/lti_public_resources.rb', __FILE__)
require 'rspec'
require 'rack/test'
require 'pry'

CONFIG_FILE = File.expand_path('../../data/public_resources_app_config.yml', __FILE__)

RSpec.configure do |config|
  config.include Rack::Test::Methods
end