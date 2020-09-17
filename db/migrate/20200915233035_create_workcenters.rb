class CreateWorkcenters < ActiveRecord::Migration[6.0]
  def change
    create_table :workcenters do |t|
      t.string :group
      t.string :name
      t.string :code
      t.text :description
      t.float :average_downtime
      t.integer :frozen_period
      t.integer :minimal_setup
      t.string :setup_reduction_type
      t.integer :average_setup
      t.integer :average_speed
      t.integer :max_deviation

      t.timestamps
    end
  end
end
