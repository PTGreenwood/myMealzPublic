class AddResolvedToSupportTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :support_tickets, :resolved, :tinyint
  end
end
