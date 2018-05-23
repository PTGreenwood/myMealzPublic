# -*- encoding : utf-8 -*-
class ChangeProductType < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :productType, :string
  end
end
