class SavedMealsController < ApplicationController


    def new
      @sm = SavedMeal.new
    end

    def create

      @sm = SavedMeal.new()
      @sm.user_id = current_user.id
      @sm.content = :content
      respond_to do |f|
          if(@sm.save)
              f.html { redirect_to "", notice: "Meal created!" }
          else
              f.html { redirect_to "", notice: "Error: Meal not saved. "}
          end
      end
  end

  def paramsfunc
    #params.require(:saved_meals).permit(:user_id, :content)
  end

end
