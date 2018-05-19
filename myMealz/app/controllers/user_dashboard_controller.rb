class UserDashboardController < ApplicationController
  respond_to :js, :json, :html, :xml

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

    @clientRestriction = Contract.where(UserID: current_user.id)
    @proteinProducts = Product.where(productType: 'protein')
    @grainProducts = Product.where(productType: 'grain')
    @dairyProducts = Product.where(productType: 'dairy')
    @vegeProducts = Product.where(productType: 'vegetable')
    @fruitProducts = Product.where(productType: 'fruit')
    @fatProducts = Product.where(productType: 'fat')
    @discProducts = Product.where(productType: 'discretionary')

    respond_to do |format|
      #format.html
      format.js
      #render :partial=>"/layouts/supports/showTickets"
    end

  end

  def saveMealData
    #    var data = {"mealname": mealName, "description": description, "mealChosen": split[0], "dayChosen": split[1],
    #"isBreakfastSuitable": isB, "isLunchSuitable": isL, "isDinnerSuitable": isD, "proteinIDs": proteinIDs,
    #"grainIDs": grainIDs, "dairyIDs": dairyIDs, "vegeIDs": vegeIDs, "fruitIDs":fruitIDs, "fatIDs": fatsIDs,
    #"discIDs": discIDs, "proteinTotal": pTotal, "carbTotal": cTotal, "fatTotal": fTotal, "calTotal": calTotal};

    dataReceived = JSON.parse(params[:mealData])

    newMeal = Savedmeal.create(
        UserID: current_user.id, MealName: dataReceived["mealname"], ProteinIDs: dataReceived["proteinIDs"],
        GrainIDs: dataReceived["grainIDs"], DairyIDs: dataReceived["dairyIDs"], VegeIDs: dataReceived["vegeIDs"],
        FruitIDs: dataReceived["fruitIDs"], FatIDs: dataReceived["fatIDs"], DiscIDs: dataReceived["discIDs"],
        totalProtein: dataReceived["proteinTotal"], totalCarb: dataReceived["carbTotal"], totalFat: dataReceived["fatTotal"],
        totalCal: dataReceived["calTotal"], IsDinnerItem: dataReceived["isDinnerSuitable"], IsLunchItem: dataReceived["isLunchSuitable"],
        IsBreakfastItem: dataReceived["isBreakfastSuitable"]
    )

    newMeal.save

    mealID = Savedmeal.find_by(MealName: dataReceived["mealname"])
    isD = false
    isL = false
    isB = false


    if(dataReceived["dayChosen"] != -1)

      if(dataReceived["mealChosen"]) == 'b'
        isB = true
      elsif(dataReceived["mealChosen"]) == 'l'
        isL = true
      elsif(dataReceived["mealChosen"]) == 'd'
        isD = true
      end

      if(Plannedmeal.find_by(UserID: current_user.id, isBreakfastItem: isB, isLunchItem: isL,
                             isDinnerItem: isD, dayOfPlannedMeal: dataReceived["dayChosen"]))

        #Already a value for this time of meal so update it.
        mealToUpdate = Plannedmeal.find_by(UserID: current_user.id, isBreakfastItem: isB, isLunchItem: isL,
                                           isDinnerItem: isD, dayOfPlannedMeal: dataReceived["dayChosen"])
        mealToUpdate.SavedMealID = mealID.id
        mealToUpdate.MealName = dataReceived["mealname"]
        mealToUpdate.save

      else
        #No meal has been planned for this day yet, so make a new plan
        plannedMeal = Plannedmeal.create(
            UserID: current_user.id, MealName: dataReceived["mealname"], SavedMealID: mealID.id,
            IsDinnerItem: isD, IsLunchItem: isL,
            IsBreakfastItem: isB, dayOfPlannedMeal: dataReceived["dayChosen"])

        plannedMeal.save
      end
    end
  end

  def getMealData

    requestReceived = JSON.parse(params[:request])
    #t.integer :UserID
    #t.integer :MealName
    #t.string :ProteinIDs
    #t.string :GrainIDs
    #t.string :DairyIDs
    #t.string :VegeIDs
    #t.string :FruitIDs
    #t.string :FatIDs
    #t.string :DiscIDs
    #t.boolean :IsDinnerItem
    #t.boolean :IsLunchItem
    #t.boolean :IsBreakfastItem

    #t.integer :proteinAMT
    #t.integer :grainAMT
    #t.integer :dairyAMT
    #t.integer :vegeAMT
    #t.integer :fruitAMT
    #t.integer :FatAMT
    #t.integer :discAMT

    if(requestReceived["meal"] == "b")
      puts("breakfast")

    elsif(requestReceived["meal"] == "l")
      puts("lunch")
    elsif(requestReceived["meal"] == "d")
      puts("dinner")
    else
      puts("NOTHING")

    end

    require 'json'

    text = "Hello world"

    json = '{"fruits": [{"name": "Apple", "location": "Harbor"}, {"name": "Banana", "location": "Kitchen"}, {"name": "Mango", "location": "Bedroom"}]}'
    fruits = JSON.parse(json)['fruits'] # append ['fruits']

    puts(fruits)
    def format_fruits(fruits)
      fruits.map do |fruit| # change each -> map
        "\n\n#{ fruit['name'] }, #{ fruit['location'] }" # delete puts, [0]
      end.join # change to_sentence -> join
    end

    text += format_fruits(fruits)
    respond_with(fruits)
  end


end

