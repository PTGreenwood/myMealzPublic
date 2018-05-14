class UserDashboardController < ApplicationController

  def support
    if(User.find_by_username(params[:id]))
        @userLogged = User.find_by_username(params[:id])
    else
      redirect_to root_path, :notice=> "You do not have access to this page."
    end
  end

  #USER SUPPORT TICKETS
  def newTicket
    @data = JSON.parse(params[:messageDetails])

    #Assigns title from current ticket
    title = @data["title"]
    message = @data["message"]
    isAdminMessage = false
    isPartOfThread = false
    sender = current_user.username
    attacheduserID = current_user.id

    #note admin_username is now admin_firstName
    newTicketToAdd = SupportTicket.create(
      ticketTitle: title, subjectBody: message,
      isAdminMessage: isAdminMessage, isPartOfThread: isPartOfThread,
      sender: sender, attachedUserID: attacheduserID)

    newTicketToAdd.save
  end


  def replyTicketMessage

    @data = JSON.parse(params[:messageDetails])
  #@tickets[counter].id
    #Get's the Currently Open Ticket
    getTicketWithID = SupportTicket.find_by(id: @data["ticketID"])
    #Assigns title from current ticket
    title = getTicketWithID.ticketTitle
    attachedToTicket = @data["ticketID"]
    message = @data["message"]
    adminAssignedToTicket = getTicketWithID.admin_assigned
    isAdminMessage = false
    isPartOfThread = true
    sender = current_user.username
    attacheduserID = current_user.id

    #note admin_username is now admin_firstName
    newTicket = SupportTicket.create(
      ticketTitle: title, attachedToTicket: attachedToTicket,
      subjectBody: message, admin_assigned: adminAssignedToTicket,
      isAdminMessage: isAdminMessage, isPartOfThread: isPartOfThread,
      sender: sender, attachedUserID: attacheduserID)

    newTicket.save

  end

  def getMessageHistory
    history ||= []
    SupportTicket.find_each do |item|
      if((item["attachedToTicket"].to_s == params[:ticketID].to_s) && item["isPartOfThread"])
        ticketDetails = {
          "ticketTitle": item["ticketTitle"],
          "attachedUserID": item["attachedUserID"],
          "attachedToTicket": item["attachedToTicket"],
          "subjectBody": item["subjectBody"],
          "recievedAt": item["created_at"],
          "resolved": item["resolved"],
          "admin_assigned": item["admin_assigned"],
          "isAdminMessage": item["isAdminMessage"],
          "isPartOfThread": item["isPartOfThread"],
          "sender": item["sender"]
        }
        history.push(ticketDetails)
      end
    end

    @data = {"ticketArray": history}
    puts @data
    respond_to do |format|
      format.html
      format.json {render json: @data.to_json}
    end
  end

  #USER MEAL PLANNER
  def showMealPlanner

    @proteinProducts = Product.where(productType: 'protein')
    @grainProducts = Product.where(productType: 'grain')
    @dairyProducts = Product.where(productType: 'dairy')
    @vegeProducts = Product.where(productType: 'vege')
    @fruitProducts = Product.where(productType: 'fruit')
    @fatProducts = Product.where(productType: 'fat')
    @discProducts = Product.where(productType: 'disc')

    respond_to do |format|
      #format.html
      format.js
      #render :partial=>"/layouts/supports/showTickets"
    end

  end




end

