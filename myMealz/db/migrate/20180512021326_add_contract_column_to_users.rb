# -*- encoding : utf-8 -*-
class AddContractColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :connectedTo, :text
  end
end
