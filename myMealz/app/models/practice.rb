class Practice < ActiveRecord::Base
  establish_connection :development

  #has_many: :dietitians, dependent: :destroy

  #Practice has many dietitians working for them
  has_many :practicedetails
  has_many :users, through: :practicedetails
end
