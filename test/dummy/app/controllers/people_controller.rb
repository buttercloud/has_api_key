class PeopleController < ActionController::Base
  include HasApiKey::Authenticator

  def index
    render text: "Victory is mine!"
  end
end
