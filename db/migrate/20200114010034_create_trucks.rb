class CreateTrucks < ActiveRecord::Migration[6.0]
  def change
    create_table :trucks do |t|
      t.string :identifier
      t.boolean :is_ramp, default: false
      t.boolean :active, default: true
      t.boolean :has_own_gps, default: false
      t.integer :vehicle_type
      t.float :capacity
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
