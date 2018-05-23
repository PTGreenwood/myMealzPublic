# -*- encoding : utf-8 -*-
class ChangeTableNameOfProductsToProducts < ActiveRecord::Migration[5.1]
  def change
    rename_table :products_tables, :products
  end
end
