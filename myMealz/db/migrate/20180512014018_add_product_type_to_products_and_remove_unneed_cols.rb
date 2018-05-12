class AddProductTypeToProductsAndRemoveUnneedCols < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :grainQty, :productType
    remove_column :products, :vegeQty
  end
end
