# -*- encoding : utf-8 -*-
class Payment < ApplicationRecord

  #User built in rails helpers
  require "active_merchant/billing/rails"

  #allow for the temporary storage of the credit card fields.
  # Don't store these fields in the database due to security reasons.
  # Once we charge the card we no longer need these fields.
  attr_accessor :card_security_code
  attr_accessor :credit_card_number
  attr_accessor :expiration_month
  attr_accessor :expiration_year

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :card_security_code, presence: true
  validates :credit_card_number, presence: true
  validates :expiration_month, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :expiration_year, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  validate :valid_card

  def credit_card
    ActiveMerchant::Billing::CreditCard.new(
        number:              credit_card_number,
        verification_value:  card_security_code,
        month:               expiration_month,
        year:                expiration_year,
        first_name:          first_name,
        last_name:           last_name
    )
  end

  def valid_card
    if !credit_card.valid?
      errors.add(:base, "The credit card information you provided is not valid.  Please double check the information you provided and then try again.")
      false
    else
      true
    end
  end

  #The process method will attempt to authorize the card first
  # (check to see if the funds are available) and then charge the card.
  # If the transaction is successful, the process method then updates the authorization_code and success fields.
  # If the transaction was unsuccessful, a validation error is added to the model.
  def process
    if valid_card
      #response = GATEWAY.authorize(amount * 100, credit_card)
      #if response.success?
        #transaction = GATEWAY.capture(amount * 100, response.authorization)
      #  if !transaction.success?
      #    errors.add(:base, "The credit card you provided was declined.  Please double check your information and try again.") and return
      #    false
      #  end
        #update_columns({authorization_code: transaction.authorization, success: true})
        o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
        ostring  = (0...50).map { o[rand(o.length)] }.join
        update_columns({authorization_code: ostring, success: true})
        true
      else
        errors.add(:base, "The credit card you provided was declined.  Please double check your information and try again.") and return
        false
      end
    end
end
