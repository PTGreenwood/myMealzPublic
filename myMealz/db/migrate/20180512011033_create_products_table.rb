# -*- encoding : utf-8 -*-
class CreateProductsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :products_tables do |t|
      t.integer :productID
      t.string :productName
      t.integer :totalCal
      t.integer :proteinQty
      t.integer :carbohydrateQty
      t.integer :fatsQty
      t.integer :grainQty
      t.integer :vegeQty
      t.integer :servingQty
      t.string :servingType #should take cup, teaspoon, tablespoon, whole, g, kg, etc
    end
  end
end
