class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= AccountBlock::Account.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
end
