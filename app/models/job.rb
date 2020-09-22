class Job < ApplicationRecord
  belongs_to :production
  belongs_to :workcenter

  def self.check_columns(columns)
    Job.upload_columns.any?{ |key, value| columns.include?(value)}
  end

  def self.upload_columns
    { 
      sequence: "Строка",
      start: "Начальная дата/время",
      end: "Конечная дата/время",
      info: "Инф-я план.",
      previous_quantity: "Good Qty (Previous Operation)",
      inks: "Color Code",
      number_ups: "#Ups",
      tools: "Used tools",
      operation: "Operation Id",
      produced: "Good Qty (Operation)",
      split_quantity: "Split Qty",
      outers: "Item Group (OU-1)",
      varnish_plate: "Varnish Plate Number",
      quantity: "Schedules Qty",
      varnish: "Varnish Code",
      part: "часть",
      fixed_date: "Фикс. дата",
      target_speed: "TargetSpeed",
      performance: "Performance (qty / h)",
      setup: "Время настройки",
      possible_workcenters: "штамп по машинам",
      operation_number: "№ опер.",
      dynamics_job: "JobId"
    }
  end

  def self.update_params(params, user)
    params[:start] = DateTime.strptime(params[:start], user.setting.time)
    params[:end] = DateTime.strptime(params[:end], user.setting.time)
    params[:fixed_date] ? params[:fixed_date] = DateTime.strptime(params[:fixed_date], user.setting.time) : nil
    params[:sequence] = params[:sequence].to_i * 10
    params[:previous_quantity] ? params[:previous_quantity] = params[:previous_quantity].delete(',').to_i : 0
    params[:number_ups] ? params[:number_ups] = params[:number_ups].delete(',').to_i : 0
    params[:produced] ? params[:produced] = params[:produced].delete(',').to_i : 0
    params[:split_quantity] ? params[:split_quantity] = params[:split_quantity].delete(',').to_i : 0
    params[:quantity] ? params[:quantity] = params[:quantity].delete(',').to_i : 0
    params[:part] ? params[:part] = params[:part].delete(',').to_i : 0
    params[:target_speed] ? params[:target_speed] = params[:target_speed].delete(',').to_i : 0
    params[:performance] ? params[:performance] = params[:performance].delete(',').to_i : 0
    params[:setup] ? params[:setup] = params[:setup].delete(',').to_d * 60 : 0
    params[:operation_number] ? params[:operation_number] = params[:operation_number].delete(',').to_i : 0
    params
  end

end
