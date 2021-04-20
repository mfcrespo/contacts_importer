class RejectedContact < ApplicationRecord
  belongs_to :user
  default_scope {order("created_at DESC")}
  validates_presence_of :error
  before_save :credit_card_validations
  before_save :card_encrypted

  def credit_card_validations
    credit_card_object = CreditCard.new(credit_card)
    self.franchise = CreditCardValidations::Detector.new(credit_card).brand_name
    self.last_digits = CreditCard.new(last_digits).credit_card_digits
  end

  def card_encrypted
    self.credit_card = CreditCard.new(credit_card).encrypted
  end
  
end
