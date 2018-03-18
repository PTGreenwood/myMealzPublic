class AddLastNameToUsers < ActiveRecord::Migration[5.1]
  def change
      add_column :users, :lastname, :string # add a new column to table "users", called "username" and of type "string"
  end
end
