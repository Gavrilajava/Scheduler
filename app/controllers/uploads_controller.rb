class UploadsController < ApplicationController

  before_action :authorize
  
  def show

  end

  def create
    file = params[:file]
    rows = CSV.read(file.path)
    column_names = rows.shift().compact
    if Production.check_columns(column_names) && Job.check_columns(column_names) 
      Production.destroy_all
      rows.each{ |row|
        workcenter = Workcenter.find_or_create_by(code: row[0].to_s)
        production = Production.find_by(order: row[column_names.index(Production.upload_columns[:order])])
        if workcenter
          if !production
            params = {}
            Production.upload_columns.each { |key, value|
              params[key] = row[column_names.index(value)]
            }
            production = Production.create(Production.update_params(params, @current_user))
            if !production.valid?
              flash.alert = production.errors.messages
            end
          end
          params = {}
          Job.upload_columns.each { |key, value|
            params[key] = row[column_names.index(value)]
          }
          params[:workcenter_id] = workcenter.id
          job = production.jobs.create(Job.update_params(params, @current_user))
          if !job.valid?
            flash.alert = job.errors.messages
          end
        else
          flash.alert = "workcenter #{row[0]} not found"
        end
      }
      Workcenter.all.each { |wc| wc.set_start_date}
    end
    redirect_to upload_path
  end

  
end
