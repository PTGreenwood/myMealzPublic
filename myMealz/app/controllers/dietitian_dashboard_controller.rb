# -*- encoding : utf-8 -*-
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

    @nameDetails ||= []

    @usersAttached ||= []
    @contracts ||= []
    Contract.find_each do |item|
      if (currentLoggedID.id == item.DietitianID)
        nameDetails = User.find_by(id: item.UserID)
        @usersAttached.push(nameDetails)
        fName = nameDetails.firstname
        lName = nameDetails.lastname
        @nameDetails.push(fName + " " + lName)
        #@nameDetails.push(lName)
        @contracts.push(item)
      end
    end
    puts("Length of the amount of contracts: #{@contracts.length}")
    puts("NameDetails: #{@nameDetails}")
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

  def convertToSafe(text)
    newText = ""

    text.split("").each do |i|
      if i == '|'
        newText += "."
      else
        newText += i
      end
    end
    return newText
  end


  def sendConnectionEmail
    received = JSON.parse(params[:request])
    safe = convertToSafe(received["userEmail"])

    if(User.find_by(email: safe))
      @userToEmail = User.find_by(email: safe)
      @dietToEmail = current_user
      UserMailer.with(user: @userToEmail, dietitian: @dietToEmail).send_apd_to_user(@userToEmail,@dietToEmail).deliver_now
    end


  end
end
