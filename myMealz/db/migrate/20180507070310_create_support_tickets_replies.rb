class CreateSupportTicketsReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :support_tickets_replies do |t|
      t.integer :admin_id
      t.string :admin_username
      t.integer :attachedUser
      t.text :subjectBody, limit: 255

      t.timestamps
    end
  end
end
