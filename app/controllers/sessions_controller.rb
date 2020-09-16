class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(name: strong_params[:name])
    if user && user.authenticate(strong_params[:password]) 
      session[:user_id] = user.id.to_s
      flash[:success] = "Logged in successfully!"
      redirect_to root_path
    else
      flash.alert = "Incorrect name or password"
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "Logged out successfully!"
    redirect_to login_path
  end

  private

  def strong_params
    params.require(:login).permit(:name, :password)
  end
end
