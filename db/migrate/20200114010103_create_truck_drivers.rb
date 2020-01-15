class CreateTruckDrivers < ActiveRecord::Migration[6.0]
  def change
    create_table :truck_drivers do |t|
      t.string :name
      t.string :username
      t.references :truck, null: false, foreign_key: true
      t.string :telephone
      t.string :pin_code
      t.string :unique_hash
      t.boolean :active
      t.string :app_version
      t.references :account, null: false, foreign_key: true
      t.string :device_name
      t.string :os_version
      t.boolean :picture_approved
      t.string :picture

      t.timestamps
    end
  end
end
