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

  def replyTicketMessage
    @data = JSON.parse(params[:messageDetails])
  #@tickets[counter].id

    #Get's the Currently Open Ticket
    getTicketWithID = SupportTicket.find_by(id: @data["ticketID"])

    #Assigns title from current ticket
    @title = getTicketWithID.ticketTitle

    #Gets first name from the currently logged in user
    @admin_firstName = current_user.firstname

    #note admin_username is now admin_firstName
    newTicket = SupportTicketsReply.create(
      admin_id: User.find_by(Firstname: @admin_firstName),
      admin_username: @admin_firstName, attachedUser: @data["ticketID"],
      subjectBody: @data["message"])

    #newTicket = SupportTicket.create(ticketTitle: @title, attachedUser:  @data["ticketID"],
      #subjectBody: @data["message"])
    newTicket.save


  end

  def deleteTicketWithID
    @ticket = params[:ticketID]
    ticketToDelete = SupportTicket.find_by(id: @ticket)

    ticketToDelete.destroy
  end
end
