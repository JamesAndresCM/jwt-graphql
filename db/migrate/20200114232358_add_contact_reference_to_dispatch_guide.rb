class AddContactReferenceToDispatchGuide < ActiveRecord::Migration[6.0]
  def change
    add_reference :dispatch_guides, :contact, null: false, foreign_key: true
  end
end
