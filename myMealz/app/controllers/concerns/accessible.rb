# -*- encoding : utf-8 -*-
module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected
  def check_user
    if current_client
      flash.clear
      # if you have rails_admin. You can redirect anywhere really
      #redirect_to(rails_admin.dashboard_path) && return
      redirect_to(index.path) && return
    elsif current_user
      flash.clear
      # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
      redirect_to(authenticated_user_root_path) && return
    end
  end
end
