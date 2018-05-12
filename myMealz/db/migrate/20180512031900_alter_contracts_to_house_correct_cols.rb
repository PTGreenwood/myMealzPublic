class AlterContractsToHouseCorrectCols < ActiveRecord::Migration[5.1]
  def change

    add_column :contracts, :grainsReq, :integer
    add_column :contracts, :fatsReq, :integer
    add_column :contracts, :discReq, :integer

  end
end
