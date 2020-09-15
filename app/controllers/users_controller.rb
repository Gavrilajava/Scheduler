class UsersController < ApplicationController

  before_action :authorize, :check_priveleges
  before_action :action_user, only: [:destroy, :update, :edit]


  def index
    @user = User.new
    @users = User.all
  end

  def edit
  
  end

  def update
    @user.update(user_params)
    redirect_to users_path
  end

  def destroy
    @user.destroy
    flash[:notice] = "User deleted successfully!"
    redirect_to users_path
  end

  def create
    @user = User.new(user_params)   
    if @user.save
      flash[:notice] = "Account created successfully!"
    else
      flash.now.alert = @user.errors
    end
    redirect_to users_path
  end

private

  def user_params
    params[:email] = params[:email].downcase! if params[:email]
    params.require(:user).permit(:name, :role, :email, :password, :password_confirmation)
  end

  def action_user
    @user = User.find(params[:id])
  end

  def check_priveleges
    redirect_to root_path, alert: 'Only Admin can access this page.' if !current_user.admin
  end
end
