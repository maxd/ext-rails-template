class ApplicationController < ActionController::Base

  TITLE = "Application Title"

  rescue_from Acl9::AccessDenied, :with => :access_denied
  
  helper :all # include all helpers, all the time
  helper_method :current_user_session, :current_user  
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :password, :password_confirmation

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def access_denied
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to root_url
    else
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_url
    end
  end


  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
end