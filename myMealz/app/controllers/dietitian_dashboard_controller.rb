class DietitianDashboardController < ApplicationController

  def support
    puts 'made it here'
    if(User.find_by_username(params[:id]))
        @userLogged = User.find_by_username(params[:id])
    else
      redirect_to root_path, :notice=> "You do not have access to this page."
    end
  end

end
