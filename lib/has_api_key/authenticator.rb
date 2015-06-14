module HasApiKey
  module Authenticator
    extend ActiveSupport::Concern

    def self.included(base)
      base.send :extend, ClassMethods
    end


    module ClassMethods
      attr_accessor :unauthorized_if
      def authenticate_api_keys(options={})
        if options[:unauthorized_if].present?
          @unauthorized_if = options[:unauthorized_if]
        end
        
        #TODO: Implement :only and :except options here
        before_action :authenticate_resource
      end
    end

    def authenticate_resource
      if self.class.unauthorized_if.present? && send(self.class.unauthorized_if) == true
        head(:unauthorized) && return
      end

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

ActionController::Base.send :include, HasApiKey::Authenticator
