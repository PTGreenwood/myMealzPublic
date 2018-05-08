class AddColumnsToSupportTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :support_tickets, :admin_assigned, :string
    add_column :support_tickets, :isAdminMessage, :boolean
  end
end
