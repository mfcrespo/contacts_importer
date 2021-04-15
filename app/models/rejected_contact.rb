class RejectedContact < ApplicationRecord
  belongs_to :user

  validates_presence_of :error
  validate :credit_card_validations
  after_validation :card_encrypted

  def credit_card_validations
    credit_card_object = CreditCard.new(credit_card)
    self.franchise = CreditCardValidations::Detector.new(credit_card).brand_name
    if franchise
      self.last_digits = CreditCard.new(last_digits).credit_card_digits
    else
      errors.add(:credit_card, 'Invalid credit card number')
      errors.add(:franchise, 'Invalid credit card number')
    end
  end

  def card_encrypted
    self.credit_card = CreditCard.new(credit_card).encrypted
  end
  
end
