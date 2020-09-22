class JobsController < ApplicationController

  before_action :current_user, :get_workcenter

  def index
    if params[:workcenter] = "first"
      params[:workcenter] = Workcenter.first.code
    end
    @jobs = @workcenter.get_jobs

  end

  def get_workcenter
    @workcenter = Workcenter.find_by(code: params[:workcenter])
    if !@workcenter 
      @workcenter = Workcenter.find_by(group: params[:workcenter])
    end
    if !@workcenter 
      @workcenter = Workcenter.first
    end
    @menu = @workcenter.menu
    @settings = @current_user.setting
  end

  def move
    position = Job.find_by(dynamics_job: move_params[:position])
    order = Job.find_by(dynamics_job: move_params[:order])
    order.update(sequence: position.sequence - 5)
    order.workcenter.calculate
    render json: {status: "OK"}
  end

  private

  def move_params
    params.require(:replace).permit(:position, :order)
  end
end
