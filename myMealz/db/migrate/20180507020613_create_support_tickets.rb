class CreateSupportTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :support_tickets do |t|
      t.string :ticketTitle
      t.integer :attachedUser
      t.text :subjectBody, limit: 255

      t.timestamps
    end
  end
end
