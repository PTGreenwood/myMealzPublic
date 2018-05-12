class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #placing this means that before everything happens
  #it will run an authenticate_user method from the devise GEM.
  #this means that you can't access any other page until you are logged in.
  before_action :authenticate_user!
  #Call the configured devise_parameter_sanitizer
  before_action :configure_permitted_parameters, if: :devise_controller?

  # protect the database, while allowing these fields to be updated.
  protected
  def configure_permitted_parameters

    #New methods
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :firstname, :lastname, :email, :password, :password_confirmation, :remember_me, :avatar, :avatar_cache, :connectedTo])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :remember_me])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :email, :password, :password_confirmation, :remember_me])

    #devise_parameter_sanitizer.permit(:account_update) {[:username, :password, :password_confirmation, :avatar, :current_password ] }


  end


#
end
