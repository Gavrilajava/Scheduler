class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(name: strong_params[:name])
    if user && user.authenticate(strong_params[:password]) 
      session[:user_id] = user.id.to_s
      redirect_to root_path, notice: 'Successfully logged in!'
    else
      flash.now.alert = "Incorrect name or password, try again."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: "Logged out!"
  end

  private

  def strong_params
    params.require(:login).permit(:name, :password)
  end
end
