# -*- encoding : utf-8 -*-
class RenameAttachedUserAndAddUserIdInSupportTickets < ActiveRecord::Migration[5.1]
  def change
    rename_column :support_tickets, :attachedUser, :attachedToTicket
    add_column :support_tickets, :attachedUserID, :bigint
  end
end
