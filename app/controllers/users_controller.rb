class UsersController < ApplicationController
  
  before_action :redirect_logged_in_user
  
  def new; end
  
  def create
    @user = User.new(user_params)
    
    if @user.save 
      login(@user)
      redirect_to cats_url
    else 
      render :new
    end
  end
  
  def user_params 
    params.require(:user).permit(:username, :password)
  end
end