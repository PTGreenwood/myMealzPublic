class DietitianDashboardController < ApplicationController

  def support
    if(User.find_by_username(params[:id]))
        @userLogged = User.find_by_username(params[:id])
    else
      redirect_to root_path, :notice=> "You do not have access to this page."
    end
  end

  def getMyClientz
    #get all the clientz and pass them through
    currentLoggedID = User.find_by_username(current_user.username)
    @extraDetails = "Empty"
    @usersAttached ||= []
    @contracts ||= []
    Contract.find_each do |item|
      if (currentLoggedID.id == item.DietitianID)
        nameDetails = User.find_by(id: item.UserID)
        @usersAttached.push(nameDetails)
        @extraDetails = nameDetails.firstname + " " + nameDetails.lastname
        @contracts.push(item)
      end
    end

    respond_to do |format|
      format.js
    end

  end

  def updateContract

    @data = JSON.parse(params[:contractDetails])

    contractToUpdate = Contract.find_by(id: @data["user"])

    #Should be cleaner way to do this...
    contractToUpdate.totalCalRestriction = @data["calRestriction"]
    contractToUpdate.proteinReq = @data["protein"].to_f
    contractToUpdate.grainsReq = @data["grains"].to_f
    contractToUpdate.dairyReq = @data["dairy"].to_f
    contractToUpdate.vegeReq = @data["vegetables"].to_f
    contractToUpdate.fruitReq = @data["fruit"].to_f
    contractToUpdate.fatsReq = @data["fats"].to_f
    contractToUpdate.discReq = @data["disc"].to_f

    contractToUpdate.save


  end
end
