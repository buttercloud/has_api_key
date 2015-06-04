class ApiKey < ActiveRecord::Base
  validates :token, presence: true, uniqueness: true
  belongs_to :authenticatable, polymorphic: true
end
