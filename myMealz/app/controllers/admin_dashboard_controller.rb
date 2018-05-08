class AdminDashboardController < ApplicationController

  require 'json'

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

  def replyTicketMessage
    #Note attached user is the ticketID so a more apt name should be
    #attachedToTicket


    @data = JSON.parse(params[:messageDetails])
  #@tickets[counter].id

    #Get's the Currently Open Ticket
    getTicketWithID = SupportTicket.find_by(id: @data["ticketID"])

    #Assigns title from current ticket
    @title = getTicketWithID.ticketTitle

    #Gets first name from the currently logged in user
    @admin_firstName = current_user.firstname

    #note admin_username is now admin_firstName
    newTicket = SupportTicket.create(
      ticketTitle: @title, attachedUser: @data["ticketID"],
      subjectBody: @data["message"], admin_assigned: @admin_firstName,
      isAdminMessage: true)

      #admin_id: User.find_by(Firstname: @admin_firstName),
      #admin_username: @admin_firstName, attachedUser: @data["ticketID"],
      #subjectBody: @data["message"])

    #newTicket = SupportTicket.create(ticketTitle: @title, attachedUser:  @data["ticketID"],
      #subjectBody: @data["message"])


    #only has Tickettitle, Attacheduser, Subjectbody, created at, updated at, resolved.
    #needs admin_assigned (which is the first name)
    #needs admin_id (which is the id if I can get it)
    newTicket.save


  end

  def getMessageHistory
    #Remidner that attachedUser is actually the ticket number.
    #a more apt name in DB should be attachedToTicket
    #@history = SupportTicket.where({attachedUser: :ticketID })
    history ||= []

    #@ticket = SupportTicket.find_by(attachedUser: 7)
    SupportTicket.find_each do |item|
      #puts "output"
      #puts item["attachedUser"]
      #puts params[:ticketID]

      #Convert to string for the compare
      if(item["attachedUser"].to_s == params[:ticketID].to_s)
        ticketDetails = {
          "ticketTitle": item["ticketTitle"],
          "attachedUser": item["attachedUser"],
          "subjectBody": item["subjectBody"],
          "resolved": item["resolved"],
          "admin_assigned": item["admin_assigned"],
          "isAdminMessage": item["isAdminMessage"],
          "isPartOfThread": item["isPartOfThread"]
        }
        history.push(ticketDetails)
      end
    end

    #Values to send through
    #ticketTitle, attachedUser, subjectBody, resolved,
    #admin_assigned, isAdminMessage, isPartOfThread

    @data = {"ticketArray": history}
    respond_to do |format|
      format.html
      format.json {render json: @data.to_json}
    end
    #@history = SupportTicket.find_by(attachedUser: :ticketID)


  end

  def deleteTicketWithID
    @ticket = params[:ticketID]
    ticketToDelete = SupportTicket.find_by(id: @ticket)

    ticketToDelete.destroy
  end
end
