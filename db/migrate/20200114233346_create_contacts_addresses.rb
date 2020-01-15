class CreateContactsAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts_addresses do |t|
      t.references :address, null: false, foreign_key: true
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
