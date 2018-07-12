class SessionsController < ApplicationController
  
  before_action :redirect_logged_in_user, except: [:destroy]
  
  def new; end
  
  
  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user 
      login(@user)
      redirect_to cats_url
    else 
      flash.now[:errors] = "Login information not found"
      render :new
    end
  end

  
  def destroy
    logout if logged_in?
    redirect_to cats_url
  end
end
