class AddDietitianIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :dietitianID, :integer
  end
end
