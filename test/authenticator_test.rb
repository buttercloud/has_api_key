require 'test_helper'

class AuthenticatorTest < ActionController::TestCase
  def setup
    @controller = PeopleController.new
  end

  def test_index_with_no_api_key
    get :index
    assert_response 401
  end

  def test_index_with_valid_api_key_param
    get(:index, { "token" => Person.create!.api_key.token })
    assert_response :success
  end

  def test_index_with_valid_api_key_header
  end

  def test_index_with_api_resource
  end

  def test_wrong_key_for_resource

  end
end
