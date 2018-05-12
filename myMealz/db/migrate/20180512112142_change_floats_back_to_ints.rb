class ChangeFloatsBackToInts < ActiveRecord::Migration[5.1]
  def change
    change_column :contracts, :proteinReq, :integer
    change_column :contracts, :grainsReq, :integer
    change_column :contracts, :dairyReq, :integer
    change_column :contracts, :vegeReq, :integer
    change_column :contracts, :fruitReq, :integer
    change_column :contracts, :fatsReq, :integer
    change_column :contracts, :discReq, :integer
  end
end
