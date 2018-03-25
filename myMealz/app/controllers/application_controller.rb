class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #Call the configured devise_parameter_sanitizer
  before_action :configure_permitted_parameters, if: :devise_controller?

  # protect the database, while allowing these fields to be updated.
  protected
  def configure_permitted_parameters
    #Deprecated methods
    #devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :firstname, :lastname, :email, :password, :password_confirmation, :remember_me) }
    #devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :password_confirmation, :remember_me) }
    #devise_parameter_sanitizer.for(:account_upate) { |u| u.permit(:firstname, :lastname, :email, :password, :password_confirmation, :remember_me) }

    #New methods
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :firstname, :lastname, :email, :password, :password_confirmation, :remember_me])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :remember_me])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :email, :password, :password_confirmation, :remember_me])
  end

end
