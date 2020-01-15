class CreateCustomFieldTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :custom_field_types do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name
      t.integer :model_type, default: 0
      t.boolean :show_in_web, default: true
      t.boolean :show_in_mobile, default: true
      t.boolean :has_many_flag, default: true

      t.index ["account_id", "model_type", "show_in_mobile"], name: "cf_by_mobile"
      t.index ["account_id", "model_type", "show_in_web"], name: "cf_by_web"
      t.index ["account_id", "name", "model_type"], name: "cft_account_name_type"
      t.timestamps
    end
  end
end
