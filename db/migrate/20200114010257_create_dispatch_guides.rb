class CreateDispatchGuides < ActiveRecord::Migration[6.0]
  def change
    create_table :dispatch_guides do |t|
      t.references :account, null: false, foreign_key: true
      t.string :code
      t.integer :dispatches_count
      t.references :place, null: false, foreign_key: true
      t.datetime :first_estimated
      t.integer :service_time
      t.datetime :min_delivery_time
      t.datetime :max_delivery_time
      t.string :beecode
      t.boolean :active
      t.integer :mode

      t.timestamps
    end
  end
end
