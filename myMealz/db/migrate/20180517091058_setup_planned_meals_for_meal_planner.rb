# -*- encoding : utf-8 -*-
class SetupPlannedMealsForMealPlanner < ActiveRecord::Migration[5.1]
  def change

    #Saved meals is a table the contains meals that users may wish to include later. It is also where the recipes
    # will be formed by using the ingredients list from there.

    #This is actually for saved meals WhOOPS
    create_table :savedmeals do |t|

      t.integer :UserID
      t.integer :MealName
      t.string :ProteinIDs
      t.string :GrainIDs
      t.string :DairyIDs
      t.string :VegeIDs
      t.string :FruitIDs
      t.string :FatIDs
      t.string :DiscIDs
      t.boolean :IsDinnerItem
      t.boolean :IsLunchItem
      t.boolean :IsBreakfastItem

      t.integer :proteinAMT
      t.integer :grainAMT
      t.integer :dairyAMT
      t.integer :vegeAMT
      t.integer :fruitAMT
      t.integer :FatAMT
      t.integer :discAMT

      t.timestamps
    end
  end
end
