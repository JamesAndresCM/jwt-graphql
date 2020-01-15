class AddAddressReferenceToDispatchGuide < ActiveRecord::Migration[6.0]
  def change
    add_reference :dispatch_guides, :address, foreign_key: true
  end
end
