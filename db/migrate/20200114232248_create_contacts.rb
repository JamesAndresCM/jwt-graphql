class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.references :account, null: false, foreign_key: true
      t.string :email
      t.string :phone
      t.string :identifier
      t.string :name
      t.integer :contact_type, default: 0, null: false
      t.datetime :last_sent_survey

      t.timestamps
    end
  end
end
