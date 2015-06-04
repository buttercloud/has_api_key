module HasApiKey
  module Authenticator
    extend ActiveSupport::Concern

    included do
      before_action :authenticate_resource
    end

    def authenticate_resource
      if params[:token].present?
        head :unauthorized unless token_valid?(params[:token])
      else
        # By HTTP Header "Authorization: Token token=your_token". This will return a 402
        # error if token is not valid or not present.
        authenticate_or_request_with_http_token do |token, options|
          token_valid?(token)
        end
      end
    end

    protected
    def token_valid?(token)
      auth_record = if defined?(api_resource)
        ApiKey.find_by(authenticatable: api_resource, api_key: token).first
      else
        ApiKey.where(token: token).first
      end

      auth_record.blank? ? false : auth_record.token == token
    end
  end
end
