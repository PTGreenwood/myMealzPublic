class UserDashboardController < ApplicationController
  respond_to :js, :json, :html, :xml
  require 'json'

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

  def idConvertHelper(stringSequence)
    #converted = stringSequence.split(',')
    #temp ||= []
    returningArray ||= []
    returningArray = returningArray.push(stringSequence.split(','))

    return returningArray
  end

  def productCollectionHelper(arrayToLoop)

    innerValues = Array.new()
    outerValues = Array.new()

    for outerItem in arrayToLoop
      puts("outer item: #{outerItem}")
      for innerItem in outerItem
        puts("Inner item #{innerItem}")
        for actualItem in innerItem
          puts("inner inner item: #{actualItem}")
          if(Product.find_by(productID: actualItem))
            puts("FOund it")
            prod = Product.find_by(productID: actualItem)
            innerValues.push(prod)
          end
        end
        outerValues << innerValues.dup
        innerValues.clear
      end
    end
    return outerValues
  end

  #Recipe options
  def showRecipeOptions

    @meals = Savedmeal.all

    proteinOuter ||= [] #is 2D Array
    grainOuter   ||= [] #is 2D Array
    dairyOuter   ||= [] #is 2D Array
    vegeOuter    ||= [] #is 2D Array
    fruitOuter   ||= [] #is 2D Array
    fatsOuter    ||= [] #is 2D Array
    discOuter    ||= [] #is 2D Array

    @proteinCollection ||= []
    @grainCollection   ||= []
    @dairyCollection   ||= []
    @vegeCollection    ||= []
    @fruitCollection   ||= []
    @fatsCollection    ||= []
    @discCollection    ||= []

    for item in @meals

      proteinOuter.push(idConvertHelper(item.ProteinIDs))
      grainOuter.push(idConvertHelper(item.GrainIDs))
      dairyOuter.push(idConvertHelper(item.DairyIDs))
      vegeOuter.push(idConvertHelper(item.VegeIDs))
      fruitOuter.push(idConvertHelper(item.FruitIDs))
      fatsOuter.push(idConvertHelper(item.FatIDs))
      discOuter.push(idConvertHelper(item.DiscIDs))

    end

    @proteinCollection = productCollectionHelper(proteinOuter)
    @grainCollection = productCollectionHelper(grainOuter)
    @dairyCollection = productCollectionHelper(dairyOuter)
    @vegeCollection = productCollectionHelper(vegeOuter)
    @fruitCollection = productCollectionHelper(fruitOuter)
    @fatsCollection = productCollectionHelper(fatsOuter)
    @discCollection = productCollectionHelper(discOuter)

    respond_to do |format|
      #format.html
      format.js
      #render :partial=>"/layouts/supports/showTickets"
    end
  end

  #Planned meal sections
  def showPlannedMeals
    puts("Maybe here")
    respond_to do |format|
      #format.html
      format.js
      #render :partial=>"/layouts/supports/showTickets"
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
      format.pdf do
        kit = PDFKit.new('views/layouts/logup/login', page_size: 'A4')
        pdf = kit.to_pdf
        send_data(pdf,
                  filename: 'testingPDFSave.pdf',
                  disposition: 'attachment',
                  type: :pdf)
      end
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

    puts(dataReceived["dayChosen"])
    puts(dataReceived["mealChosen"])
    if(dataReceived["dayChosen"] != -1)

      if(dataReceived["mealChosen"]) == 'Breakfast'
        isB = true
      elsif(dataReceived["mealChosen"]) == 'Lunch'
        isL = true
      elsif(dataReceived["mealChosen"]) == 'Dinner'
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

  def mealHelper(receivedString)
    arrCopy ||= []
    for i in receivedString
      if(i != ',')
        arrCopy.push(i)
      end
    end
    puts(arrCopy)
    return arrCopy
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

    isDin = false
    isLun = false
    isBre = false

    if(requestReceived["meal"] == "breakfast")
      isBre = true
    elsif(requestReceived["meal"] == "lunch")
      isLun = true
    elsif(requestReceived["meal"] == "dinner")
      isDin = true
    end


    if(Plannedmeal.find_by(UserID: current_user.id, isBreakfastItem: isBre, isLunchItem: isLun,
                           isDinnerItem: isDin, dayOfPlannedMeal: requestReceived["day"]))

      pm = Plannedmeal.find_by(UserID: current_user.id, isBreakfastItem: isBre, isLunchItem: isLun,
                               isDinnerItem: isDin, dayOfPlannedMeal: requestReceived["day"])

      mealToReturn = Savedmeal.find_by(id: pm.SavedMealID)

      proteinIDs = {"IDs": mealHelper(mealToReturn.ProteinIDs.split(','))}
      grainIDs = {"IDs": mealHelper(mealToReturn.GrainIDs.split(','))}
      dairyIDs = {"IDs": mealHelper(mealToReturn.DairyIDs.split(','))}
      vegeIDs  = {"IDs": mealHelper(mealToReturn.VegeIDs.split(','))}
      fruitIDs = {"IDs": mealHelper(mealToReturn.FruitIDs.split(','))}
      fatIDs = {"IDs": mealHelper(mealToReturn.FatIDs.split(','))}
      discIDs = {"IDs": mealHelper(mealToReturn.DiscIDs.split(','))}

      @reply = {"mealname": mealToReturn.MealName, "proteinIDs": proteinIDs.to_json, "grainIDs": grainIDs.to_json,
                "dairyIDs": dairyIDs.to_json, "vegeIDs": vegeIDs.to_json, "fruitIDs": fruitIDs.to_json,
                "fatIDs": fatIDs.to_json, "discIDs": discIDs.to_json}

    else
      puts("NOTHING FOUND FOR THAT SEARCH")
      @reply = {"mealname": '-1', "proteinIDs": '', "grainIDs": '', "dairyIDs": '', "vegeIDs": '', "fruitIDs": '',
                "fatIDs": '', "discIDs": ''}
    end
    respond_with(JSON.parse(@reply.to_json))
  end


end

