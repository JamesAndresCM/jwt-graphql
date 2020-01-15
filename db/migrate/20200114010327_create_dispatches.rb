class CreateDispatches < ActiveRecord::Migration[6.0]
  def change
    create_table :dispatches do |t|
      t.references :account, null: false, foreign_key: true
      t.integer :guide_id
      t.references :route, null: false, foreign_key: true
      t.integer :status_id
      t.datetime :estimated_at
      t.datetime :arrived_at
      t.integer :slot
      t.boolean :has_form
      t.boolean :is_trunk
      t.boolean :is_pickup
      t.integer :end_type
      t.integer :delivery_time
      t.boolean :is_deleted
      t.float :load
      t.integer :priority
      t.boolean :delivered_in_client

      t.timestamps
    end
  end
end
