# -*- encoding : utf-8 -*-
class ChangeDietIdToString < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :dietitianID, :string
  end
end
