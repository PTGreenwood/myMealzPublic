# -*- encoding : utf-8 -*-
class AddSenderToSupportTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :support_tickets, :sender, :string
  end
end
