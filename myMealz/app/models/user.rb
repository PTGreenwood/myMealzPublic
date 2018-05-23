# -*- encoding : utf-8 -*-
class User < ApplicationRecord
#USer is the Dietitan Role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Paperclip gem, for profile picture
  has_attached_file :avatar, styles: { medium: "300x300", thumb: "100x100" }
  #Extra validations
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  # Validate filename only allow png or jpeg
  validates_attachment_file_name :avatar, matches: [/png\Z/, /jpe?g\Z/]


  after_create :send_admin_mail

  def send_admin_mail
    UserMailer.send_welcome_email(self).deliver_later
  end
end
