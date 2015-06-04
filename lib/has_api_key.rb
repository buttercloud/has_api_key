require 'has_api_key/authenticatable'
require 'has_api_key/authenticator'
require 'has_api_key/api_key'

module HasApiKey
  require 'has_api_key/engine' if defined?(Rails)
end
