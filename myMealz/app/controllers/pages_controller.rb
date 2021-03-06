# -*- encoding : utf-8 -*-
# The pages controller contains all of the code for any page inside of /pages
class PagesController < ApplicationController

  skip_before_action :authenticate_user!, :only => [:index]

#This means that it will skip the before action define din application_controller (SITE WIDE CONTROLLER)
#add not have authentication on the landing page.

  #backend code for pages/index

  def showProfile
    respond_to do |format|
      format.js
    end
  end
  #Index is landing page.
  def index

  end

  #backend code for pages/home
  def home

  end

  def redirectOnFail
    redirect_to root_path
  end

  def showTickets

    #get all the tickets and pass them through
    @tickets ||= []
      SupportTicket.find_each do |item|
        if (current_user.admin_role == true)
          @tickets.push(item)
        elsif(item.attachedUserID == current_user.id)
          @tickets.push(item)
        end
      end

    respond_to do |format|
      format.js
    end
    #render :partial=>"layouts/supports/showTickets"
  end

  #backend code for pages/dashboard
  def dashboard
    #grab the username from the URL as :id (check routes.rb)
    if (User.find_by_username(params[:id]))
      @username = params[:id] #<-- Specified in routes as user/:id which is a constant immutatble symbol value
      tempUser = User.find_by_username(params[:id])
      if(!User.find_by_dietitianID(tempUser.connectedTo))
        tempUser.connectedTo = ""
        tempUser.save
      end
    else

      redirect_to root_path, :notice=> "User not found!"
    end

  end

  #backend code for pages/explore
  def explore
  end

end

