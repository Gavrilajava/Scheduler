class AddStartDateToWorkcenter < ActiveRecord::Migration[6.0]
  def change
    add_column :workcenters, :start_date, :datetime
  end
end
