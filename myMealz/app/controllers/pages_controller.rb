# The pages controller contains all of the code for any page inside of /pages
class PagesController < ApplicationController

  #backend code for pages/index
  def index
  end

  #backend code for pages/home
  def home
  end

  #backend code for pages/profile
  def profile
    #grab the username from the URL as :id (check routes.rb)
    if (User.find_by_username(params[:id]))
      @username = params[:id] #<-- Specified in routes as user/:id which is a constant immutatble symbol value
    else
      #redirect to 404 (root for now)
      redirect_to root_path, :notice=> "User not found!"
    end

    @savedmeals = SavedMeal.all.where("user_id = ?", User.find_by_username(params[:id]).id)
    @newSavedMeal = SavedMeal.new
  end

  #backend code for pages/explore
  def explore

    #Display all Saved Meals here.. Not where we want it but ohwell.
    #Shows how to show all recipes.. or something of the like
    @savedmeals = SavedMeal.all
  end
end
