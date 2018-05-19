class SetupPlannedMealsTableForMealPlanner < ActiveRecord::Migration[5.1]
  def change

    #Not to be confused with previous migration... Doubley named
    create_table :plannedmeals do |t|

      t.integer :UserID
      t.boolean :IsDinnerItem
      t.boolean :IsLunchItem
      t.boolean :IsBreakfastItem
      t.string :dayOfPlannedMeal

      t.integer :SavedMealID
      t.integer :MealName

      t.timestamps
    end
  end
end
