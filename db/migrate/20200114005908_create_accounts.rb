class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :email
      t.string :type
      t.string :timezone, null: true, default: 'Santiago'
      t.string :api_key, limit: 72
      t.boolean :chat_enabled, default: false
      t.string :language, null: true, default: 'es'
      t.string :country, null: true, default: 'CL', limit: 2
      t.boolean :active, null: true, default: true
      t.boolean :has_ondemand, null: true, default: true

      t.timestamps
    end
  end
end
