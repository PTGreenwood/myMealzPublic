# -*- encoding : utf-8 -*-
class SetupContractTable < ActiveRecord::Migration[5.1]
  def change

    create_table :contracts do |t|
      t.integer :UserID
      t.integer :DietitianID
      t.integer :totalCalRestriction
      t.integer :proteinReq
      t.integer :carbReq
      t.integer :fatsReq
      t.integer :grainReq
      t.integer :vegeReq

      t.timestamps
    end
  end
end
