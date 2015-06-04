class ApiKey < ActiveRecord::Base
  belongs_to :authenticatable, polymorphic: true
end
