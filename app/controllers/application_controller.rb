class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :ensure_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # appends path to the end of inBloom api base url
  def inbloom_get(path)
    inbloom_api_uri = Pathname.new('https://api.sandbox.slcedu.org/api/rest/v1/')
    get(inbloom_api_uri.join(path).to_s)
  end

  def get(path)

    headers = {"Accept" => 'application/vnd.slc+json',
               "Content-Type" => 'application/vnd.slc+json',
               "Authorization" => "bearer #{session[:token]}"}

    api_call = URI.parse(path)
    http_method = request.method.underscore.to_sym
    HTTParty.send(http_method, api_call.to_s, :headers => headers)
  end

  private

  def ensure_user
    unless current_user
      redirect_to "/auth/slc"
    end
  end
end
