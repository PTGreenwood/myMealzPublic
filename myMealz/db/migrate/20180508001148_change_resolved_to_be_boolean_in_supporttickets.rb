# -*- encoding : utf-8 -*-
class ChangeResolvedToBeBooleanInSupporttickets < ActiveRecord::Migration[5.1]
  def change
    change_column :support_tickets,
:resolved, :boolean
  end
end
