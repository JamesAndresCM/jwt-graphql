class AddAccountIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :account, index: true
  end
end
