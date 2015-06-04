module HasApiKey
  module Authenticatable 
    extend ActiveSupport::Concern

    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def has_api_key(options={})
        has_one :api_key, as: :authenticatable
        before_create :generate_api_key
      end
    end

    def generate_api_key
      self.api_key = ApiKey.new(token: SecureRandom.hex)
    end

  end
end

ActiveRecord::Base.send :include, HasApiKey::Authenticatable
