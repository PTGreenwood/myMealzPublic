# -*- encoding : utf-8 -*-
class AddCalorieColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :savedmeals, :totalCalorie, :integer
  end
end
