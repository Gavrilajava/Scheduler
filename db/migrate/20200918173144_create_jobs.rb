class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.integer :production_id
      t.integer :workcenter_id
      t.integer :sequence
      t.datetime :start
      t.datetime :end
      t.string :info
      t.integer :previous_quantity
      t.string :inks
      t.string :number_ups
      t.string :tools
      t.string :operation
      t.integer :produced
      t.integer :split_quantity
      t.string :outers
      t.string :varnish_plate
      t.integer :quantity
      t.string :varnish
      t.integer :part
      t.datetime :fixed_date
      t.integer :target_speed
      t.integer :performance
      t.integer :setup
      t.string :possible_workcenters
      t.integer :operation_number
      t.string :dynamics_job

      t.timestamps
    end
  end
end
