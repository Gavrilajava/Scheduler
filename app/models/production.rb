class Production < ApplicationRecord

  has_many :jobs, dependent: :destroy

  def self.check_columns(columns)
    Production.upload_columns.any?{ |key, value| columns.include?(value)}
  end

  def self.upload_columns
    {
      order: "Производство",
      cad: "CAD#",
      next_call_off: "1-й отзыв",
      info: "Инф-я план.2",
      combination: "Комбинация",
      inline_coding: "Inline Coding",
      variant: "Config Id",
      gluing_points: "#gluing points",
      item: "Item Id",
      board: "Item Category ProdTable (200)",
      route: "Production Route (Combination)",
      customer: "Customer Alias",
      name: "Item Name (FG / Configuration)",
      next_call_off_quantity: "Call-Off Qty",
      status: "Production Order Status",
      qty_per_pallet: "Qty per palet",
      confirmed_date: "conf. Shipping Date",
      required_date: "Req. Shipping Date",
      order_type: "Sales Order (Repeat Type)",
      sales_order_line: "Sales Order Position",
      sales_order: "Sales Order Id",
      possible_date: "possible Date (Planning)",
      order_date: "Deliver Date (Production Order)"
    }
  end

  def self.update_params(params, user)

    params[:confirmed_date] ? params[:confirmed_date] = DateTime.strptime(params[:confirmed_date], user.setting.date) : nil
    params[:required_date] ? params[:required_date] = DateTime.strptime(params[:required_date], user.setting.date): nil
    params[:possible_date] ? params[:possible_date] = DateTime.strptime(params[:possible_date], user.setting.date): nil
    params[:order_date] ? params[:order_date] = DateTime.strptime(params[:order_date], user.setting.date): nil
    params
  end
end
