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
    logger.debug "API start: #{api_call}, :headers => #{headers}"
    api_start = Time.now
    result = HTTParty.send(:get, api_call.to_s, :headers => headers)
    logger.debug "API complete. duration:#{api_start-Time.now}"
  end
  helper_method :get

  private

  def ensure_user
    unless current_user
      redirect_to "/auth/slc"
    end
  end

  # introspects item's links for rel, returns href
  def href_for(item, rel)
    item.links.find {|item| item.rel == rel.to_s}.href
  end
  helper_method :href_for

  def hashie_from_json(json_data)
    hash = JSON.parse json_data
    hashie_from_hash(hash)
  end
  helper_method :hashie_from_json

  def hashie_from_hash(array_hash)
    case array_hash
    when Hash
      Hashie::Mash.new(array_hash)
    when Array
      array_hash.map{|ah| hashie_from_hash(ah)}
    else
      raise "Unrecognized type for Hashie"
    end
  end
end
