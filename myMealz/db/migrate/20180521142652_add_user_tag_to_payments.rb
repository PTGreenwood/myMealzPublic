class AddUserTagToPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :attachedUserID, :integer
  end
end
