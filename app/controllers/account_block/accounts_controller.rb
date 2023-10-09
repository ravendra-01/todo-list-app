module AccountBlock
  class AccountsController < ApplicationController
    before_action :validate_user, only: [:index]

    def index
    end

    def new
    end

    def create
      @account = Account.new(params.require(:account).permit(:first_name, :last_name, :email, :phone_number, :password))
      if @account.save
        session[:user_id] = @account.id
        flash[:notice] = "New User successfully added!"
        # redirect_to "/users/#{@user.id}"
        redirect_to "/"
      else
        flash[:errors] = @account.errors
        redirect_to "/account_block/accounts/new"
      end
    end

    private

    def validate_user
      redirect_to "/account_block/accounts/new" unless current_user
    end
  end
end
