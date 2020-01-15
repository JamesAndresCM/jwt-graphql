class AddPickupAddressToDispatchGuide < ActiveRecord::Migration[6.0]
  def change
    add_column :dispatch_guides, :pickup_address_id, :integer
    add_index :dispatch_guides, :pickup_address_id
  end
end
