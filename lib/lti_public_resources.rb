require 'lti_public_resources/web_app'
require 'lti_public_resources/api_app'
require 'lti_public_resources/version'

module LtiPublicResources
  BASE_PATH = File.expand_path('../../.', __FILE__)

   def self.symbolize_keys(hash)
    hash.inject({}){|result, (key, value)|
      new_key = case key
                when String then key.to_sym
                else key
                end
      new_value = case value
                  when Hash then symbolize_keys(value)
                  when Array then value.map{ |v| v.is_a?(Hash) ? symbolize_keys(v) : v }
                  else value
                  end
      result[new_key] = new_value
      result
    }
  end
end
