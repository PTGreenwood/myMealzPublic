# -*- encoding : utf-8 -*-
class ChangeColumnTypes < ActiveRecord::Migration[5.1]
  def change
    change_column :plannedmeals, :MealName, :string
    change_column :savedmeals, :MealName, :string
    add_column :savedmeals, :SavedMealID, :integer

  end
end
