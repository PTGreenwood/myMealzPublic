class User < ApplicationRecord
#USer is the Dietitan Role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Dietitian works at many practices (outlined in practicestaffs)
  has_many :practicedetails
  #has_many :practices, through: :practicedetails

  if :dietitian_role == 1
    has_many :contracts, dependent: :destroy
    has_many :users, through: :contracts, dependent: :destroy
  elsif :user_role == 1
    has_one :contract
    #where users are dietitians, so they only have one of them
    has_one :users, through: :contract
  end


  #after_create :send_admin_mail

  def send_admin_mail
    UserMailer.send_welcome_email(self).deliver_later
  end
end
