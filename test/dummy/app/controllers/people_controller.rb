class PeopleController < ActionController::Base
  authenticate_api_keys unauthorized_if: :fail_now? 

  def index
    render text: "Victory is mine!"
  end

  protected
  def fail_now?
    params[:fail_now] == "yes"
  end
end
