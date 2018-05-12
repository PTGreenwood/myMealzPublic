class DropUnneededTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :practices
    drop_table :practicedetails
    drop_table :dietclientplans
    drop_table :clients
    drop_table :savedmeals
  end
end
