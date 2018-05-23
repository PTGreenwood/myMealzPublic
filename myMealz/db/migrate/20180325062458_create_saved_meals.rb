# -*- encoding : utf-8 -*-
#created with
# rails generate model SavedMeals content:text user:references

class CreateSavedMeals < ActiveRecord::Migration[5.1]
  def change
    create_table :saved_meals do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps null: false
    end
    add_index :saved_meals, [:user_id, :created_at] #compound index, joining two together
  end
end
