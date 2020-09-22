class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.integer :user_id
      t.string :time
      t.string :date

      t.timestamps
    end
  end
end
