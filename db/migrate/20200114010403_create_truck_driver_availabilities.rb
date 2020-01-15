class CreateTruckDriverAvailabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :truck_driver_availabilities do |t|
      t.references :truck_driver, null: false, foreign_key: true
      t.references :place, null: false, foreign_key: true
      t.boolean :available
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
