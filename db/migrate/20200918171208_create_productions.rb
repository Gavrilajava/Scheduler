class CreateProductions < ActiveRecord::Migration[6.0]
  def change
    create_table :productions do |t|
      t.string :order
      t.string :cad
      t.date :next_call_off
      t.string :info
      t.string :combination
      t.string :inline_coding
      t.string :variant
      t.string :gluing_points
      t.string :item
      t.string :board
      t.string :route
      t.string :customer
      t.string :name
      t.integer :next_call_off_quantity
      t.string :status
      t.integer :qty_per_pallet
      t.date :confirmed_date
      t.date :required_date
      t.string :order_type
      t.string :sales_order_line
      t.string :sales_order
      t.date :possible_date
      t.date :order_date

      t.timestamps
    end
  end
end
