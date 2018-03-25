class SavedMeal < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true #user_id must be there
  validates :content, presence: true, length: { maximum: 140 } #Forcing this to cap at 140 chars
  default_scope -> { order(created_at: :desc) } # newest content first <-- testing
end
