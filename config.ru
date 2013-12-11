require './lib/lti_public_resources'

config_file = File.expand_path('../data/public_resources_app_config.yml', __FILE__)
run LtiPublicResources::WebApp.new(nil, config_file)