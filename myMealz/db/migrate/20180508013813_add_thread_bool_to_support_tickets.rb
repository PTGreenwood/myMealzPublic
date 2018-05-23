# -*- encoding : utf-8 -*-
class AddThreadBoolToSupportTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :support_tickets, :isPartOfThread, :boolean
  end
end
