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
      auth_record = ApiKey.where(token: token).first

      valid = if auth_record.present? 
        auth_record.token == token
      else
        false 
      end

      @api_loaded_resource = auth_record.authenticatable if valid
      valid
    end
  end
end
