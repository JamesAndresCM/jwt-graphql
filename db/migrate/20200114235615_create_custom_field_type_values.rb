class CreateCustomFieldTypeValues < ActiveRecord::Migration[6.0]
  def change
    create_table :custom_field_type_values do |t|
      t.references :custom_field_type, null: false, foreign_key: true
      t.string :color
      t.string :value

      t.timestamps
    end
  end
end
