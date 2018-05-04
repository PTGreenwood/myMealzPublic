class AdminDashboardController < ApplicationController



  def support
    if(User.find_by_username(params[:id]))
        @userLogged = User.find_by_username(params[:id])
        if(@userLogged.admin_role == false)
          redirect_to root_path, :notice=> "You do not have access to this page."
        end
    end
  end

  def alterContent
  end
end
