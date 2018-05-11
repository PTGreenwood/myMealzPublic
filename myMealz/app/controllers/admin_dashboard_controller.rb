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

    @data = JSON.parse(params[:messageDetails])

    getTicketWithID = SupportTicket.find_by(id: @data["ticketID"])

    title = getTicketWithID.ticketTitle
    attachedToTicket = @data["ticketID"]
    message = @data["message"]
    adminAssignedToTicket = current_user.username
    isAdminMessage = true
    isPartOfThread = true
    sender = current_user.username
    attacheduserID = getTicketWithID.attachedUserID

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
    #@history = SupportTicket.find_by(attachedUser: :ticketID)
  end

  def deleteTicketWithID
    @ticket = params[:ticketID]
    ticketToDelete = SupportTicket.find_by(id: @ticket)

    ticketToDelete.destroy
  end

  def resolveTicket
    @ticket = params[:ticketID]
    ticketToResolve = SupportTicket.find_by(id: @ticket)

    ticketToResolve.resolved = true
    ticketToResolve.save
  end
end
