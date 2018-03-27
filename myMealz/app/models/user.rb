class User < ApplicationRecord
#USer is the Dietitan Role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Dietitian works at many practices (outlined in practicestaffs)
  has_many :practicedetails
  #has_many :practices, through: :practicedetails

  has_many :contracts, dependent: :destroy
  has_many :clients, through: :contracts, dependent: :destroy



  #after_create :send_admin_mail

  def send_admin_mail
    UserMailer.send_welcome_email(self).deliver_later
  end
end
