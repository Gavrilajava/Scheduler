class UploadsController < ApplicationController

  def show

  end

  def create
    file = params[:file]
    rows = CSV.read(file.path)
    column_names = rows.shift()
    rows.each{ |row|
      workcenter = Workcenter.find_or_create_by(code: row[column_names.index("﻿Рабочий центр")])
    }
    
  end

  
end
