class CreateCustomFields < ActiveRecord::Migration[6.0]
  def change
    create_table :custom_fields do |t|
      t.references :custom_field_type, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.integer :model_id
      t.string :model_type
      t.string :value

      t.timestamps
    end
  end
end
