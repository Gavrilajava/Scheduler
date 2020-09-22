class SettingsController < ApplicationController

  before_action :current_user, :get_setting

  def edit
  
  end

  def update
    if @setting.update(strong_params)
      flash[:success] = "Settings updated successfully!"
    else
      flash.alert = @setting.errors.messages
    end
    redirect_to settings_path
  end

  private

  def get_setting
    if @current_user.setting
      @setting = @current_user.setting
    else
      @setting = Setting.create(user: @current_user)
    end
  end

  def strong_params
    params.require(:setting).permit(:time, :date)
  end

end
