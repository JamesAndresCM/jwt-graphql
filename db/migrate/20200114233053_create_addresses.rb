class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name
      t.string :name_correct
      t.string :city
      t.string :state
      t.string :postal_code
      t.decimal :latitude, precision: 18, scale: 10
      t.decimal :latitude_proposed, precision: 18, scale: 10
      t.decimal :longitude, precision: 18, scale: 10
      t.decimal :longitude_proposed, precision: 18, scale: 10
      t.string :country
      t.integer :geocoding_status, default: 0

      t.timestamps
    end
  end
end
