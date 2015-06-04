require 'test_helper'

class AuthenticatableTest < ActiveSupport::TestCase
  def test_behaves_like_an_authenticatable_mixin
    assert_respond_to Person.new, :api_key
  end

  def test_creates_api_key_on_create
    p = Person.new
    p.save!
    assert_not_nil p.api_key
    assert ApiKey.count, 1
  end

  def test_api_key_doesnt_change_on_save
    p = Person.create!
    original_api_key_token = p.api_key.token
    
    p.update_attributes(name: "Peter Griffin")
    assert_equal(original_api_key_token, p.api_key.token)
  end
end
