class RemovingSomeSavedMealsColumnsAndRenamingOthers < ActiveRecord::Migration[5.1]
  def change
    rename_column :savedmeals, :proteinAMT, :totalProtein
    rename_column :savedmeals, :grainAMT, :totalCarb
    rename_column :savedmeals, :dairyAMT, :totalFat
    rename_column :savedmeals, :vegeAMT, :totalCal

    remove_column :savedmeals, :fruitAMT
    remove_column :savedmeals, :FatAMT
    remove_column :savedmeals, :discAMT

  end
end
