class UsersController < ApplicationController

  before_action :authorize, :check_priveleges
  before_action :action_user, only: [:destroy, :update, :edit]


  def index
    @action_user = User.new
    @users = User.all
  end

  def edit
  
  end 

  def update
    if !user_params[:password]
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end
    if @action_user.update(user_params)
      flash[:success] = "User updated successfully!"
      redirect_to users_path
    else
      flash.alert = @action_user.errors.messages
      redirect_to edit_user_path(@action_user)
    end
  end

  def destroy
    if  @action_user.destroy
      flash[:success] = "User deleted successfully!"
    else
      flash.alert = @action_user.errors.messages
    end
    redirect_to users_path
  end

  def create
    @action_user = User.new(user_params)   
    if @action_user.save
      flash[:success] = "Account created successfully!"
    else
      flash.alert = @action_user.errors.messages
    end
    redirect_to users_path
  end

private

  def user_params
    params.require(:user).permit(:name, :role, :email, :password, :password_confirmation)
  end

  def action_user
    @action_user = User.find(params[:id])
  end

  def check_priveleges
    redirect_to root_path, alert: 'Only Admin can access this page.' if !current_user.admin
  end
end
