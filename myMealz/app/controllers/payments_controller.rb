class PaymentsController < ApplicationController
  def connector

    @payments = Payment.all
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.attachedUserID = current_user.id
    if @payment.save
      if @payment.process
        @update = current_user
        @update.dietitian_role = true
        @update.user_role = false
        @update.save
        redirect_to payments_path, notice: "The user has been successfully charged." and return
      end
    end
    render 'new'
  end

  private
  def payment_params
    params.require(:payment).permit(:first_name, :last_name, :credit_card_number, :expiration_month, :expiration_year, :card_security_code, :amount)
  end

end
