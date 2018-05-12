class DietitianDashboardController < ApplicationController

  def support
    puts 'made it here'
    if(User.find_by_username(params[:id]))
        @userLogged = User.find_by_username(params[:id])
    else
      redirect_to root_path, :notice=> "You do not have access to this page."
    end
  end

  def getMyClientz
    puts 'At myClientz for Dietitian'

    #Do authentication stuff
    if(User.find_by_username(params[:id]))
      @userLogged = User.find_by_username(params[:id])
      if(@userLogged.dietitian_role == false)
        redirect_to root_path, :notice=> "You do not have access to this page."
      end
    else
      redirect_to root_path, :notice=> "You do not have access to this page."
    end

    #get all the clientz and pass them through
    puts "current user id is: "
    puts current_user.id
    @linkedUsers ||= []
    #Contract.find_each do |item|
     # if (current_user.admin_role == true)
      #  @tickets.push(item)
      #elsif(item.attachedUserID == current_user.id)
      #  @tickets.push(item)
      #end
    #end

    #respond_to do |format|
    #  format.js
    #end
    #render :partial=>"layouts/supports/showTickets"
  end

  #In the Contract table
  # ID is auto and primary key so can't use that. Pretty much Contract ID
  # UserID = User.ID <-- User linked under
  # DietitianID = User.ID for a dietitian_role <-- Dietitian linked Under
  # Total Calorie Restriction: Integer (KCals or Cals or KJs?)
  # Protein : Integer (grams)
  # Carbohydrate : Integer (grams)
  # Fats : Integer (grams)
  # Grain : Integer (grams)
  # Vegetables : Integer (grams)
end
