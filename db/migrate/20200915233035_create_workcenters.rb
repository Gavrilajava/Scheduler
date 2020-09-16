class CreateWorkcenters < ActiveRecord::Migration[6.0]
  def change
    create_table :workcenters do |t|
      t.string :group
      t.string :name
      t.float :downtime
      t.integer :frozen
      t.integer :min_setup
      t.string :setup_reduction_type
      t.integer :avg_setup
      t.integer :avg_speed

      t.timestamps
    end
  end
end
