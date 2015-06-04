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
    p = Person.create!
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(p.api_key.token)

    get(:index)
    assert_response :success
  end

  def test_index_with_invalid_api_key_param
    p = Person.create!
    get(:index, { "token" => "123123123" })
    assert_response 401
  end

  def test_index_with_invalid_api_key_header
    p = Person.create!
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials("randomstring")

    get(:index)
    assert_response 401
  end
 
  def test_resource_assigns_from_api_key
    p = Person.create!
    p2 = Person.create!
    get(:index, { "token" => p.api_key.token })

    assert_not_nil assigns(:api_loaded_resource)
    assert_equal(assigns(:api_loaded_resource), p)
  end

  def test_invalid_request_should_not_assign_resource
    get(:index)
    assert_nil assigns(:api_loaded_resource)
  end
end
