module AccountBlock
  class LoginsController < ApplicationController

    def new
    end

    def create
      user = Account.find_by(email: params[:login][:email])
      if user && user.authenticate(params[:login][:password])
        session[:user_id] = user.id
        token = JsonWebToken.encode(user.id)
        flash[:notice] = "Logged in successfully"
        redirect_to "/"
      else
        flash.now[:alert] = "There was something wrong with your login details"
        render '/account_block/logins/new'
      end
    end

    def end_session
      session[:user_id] = nil
      flash[:notice] = "You have been signed out!"
      redirect_to "/account_block/logins/new"
    end

    private

    def validate_user
      redirect_to "/user/new" unless current_user
    end
  end
end