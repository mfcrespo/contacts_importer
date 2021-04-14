class CreditCard < ApplicationRecord
    
  def initialize(credit_card)
    @credit_card = credit_card
  end

  def credit_card_digits
    @credit_card.last(4).to_s
  end 

  def encrypted
    BCrypt::Password.create(@credit_card)
  end
end
