# -*- encoding : utf-8 -*-
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end

class UserMailer < ApplicationMailer
  default from: 'welcome.myMealz@gmail.com'

  def send_welcome_email(user)
    @user = user
    mail(:to => @user.email, :subject => "Welcome!")
  end

  def send_apd_to_user(user, dietitian)
    puts("Imere here with dietitian #{user.firstname} and user: #{dietitian.firstname}")
    @user = user
    @dietitian = dietitian
    mail(:to=> @user.email, :subject => "A Dietitian wants to link in with you")
  end

end
