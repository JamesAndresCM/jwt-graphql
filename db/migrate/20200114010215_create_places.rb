class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name
      t.string :address
      t.decimal :latitude, precision: 9, scale: 6
      t.decimal :longitude, precision: 9, scale: 6
      t.boolean :is_deleted, null: true, default: false

      t.timestamps
    end
  end
end
