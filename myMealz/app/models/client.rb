class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  #has_one :contract
  #where users are dietitians, so they only have one of them
  #has_one :users, through: :contract


 #after_create :send_admin_mail

  #def send_admin_mail
  #  UserMailer.send_welcome_email(self).deliver_later
  #end
end
