class SessionsController < ApplicationController
  skip_before_filter :ensure_user

  def create
    auth = request.env["omniauth.auth"]
    session[:token] = auth[:credentials][:token]
    puts session[:token]
    Rails.logger.info session[:token]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session.delete(:user_id)
    session.delete(:token)
    redirect_to root_url, :notice => "Signed out!"
  end

  def failure
    failure_msg = "Couldn't locate a user with those credentials."
    flash[:failure] = "Sorry, could not log you in"
    current_user.destroy if current_user
    @current_user = nil
    session.delete(:user_id)
    session.delete(:token)
    redirect_to(login_url) and return
  end

end
