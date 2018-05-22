class AddDescriptionMethodToSavedMeals < ActiveRecord::Migration[5.1]
  def change
    add_column :savedmeals, :description, :text
    add_column :savedmeals, :method, :text
  end
end
