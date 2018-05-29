# -*- encoding : utf-8 -*-
class ChangeIntsToFloat < ActiveRecord::Migration[5.1]
  def change
    rename_column :contracts, :grainReq, :grainsReq
    change_column :contracts, :proteinReq, :float
    change_column :contracts, :grainsReq, :float
    add_column    :contracts, :dairyReq, :integer
    change_column :contracts, :dairyReq, :float
    change_column :contracts, :vegeReq, :float
    add_column    :contracts, :fruitReq, :integer
    change_column :contracts, :fruitReq, :float
    change_column :contracts, :fatsReq, :float
    change_column :contracts, :discReq, :float
  end
end
