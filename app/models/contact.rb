class Contact < ApplicationRecord
  belongs_to :user
  before_save :sanitize_text
  default_scope {order("created_at DESC")}

  NAME_REGEX_VALID = /\A[a-zA-Z\s-]+\z/
  PHONE_REGEX_VALID = /\(\+\d{2}\)\s\d{3}\s\d{3}\s\d{2}\s\d{2}|\(\+\d{2}\)\s\d{3}\-\d{3}\-\d{2}\-\d{2}/

  validates_presence_of :name, :birthday, :phone, :address, :credit_card, :last_digits, :email,
                         message: "Can't be blank"

  validates_presence_of :franchise, message: "Invalid credit card"                        

  validates :name, format: { with: NAME_REGEX_VALID, message: 'Name with special character arent allowed, only "-" is allowed' }
  validate :valid_birthday
  validates :phone, format: { with: PHONE_REGEX_VALID, message: 'Please include de phone in the next formats: (+57) 320 432 05 09 or (+57) 320-432-05-09'}
  validates :email, email: true, uniqueness: { scope: :user_id, message: "You have a contact with the same email" }
  validate :credit_card_validations
  after_validation :card_encrypted

  def valid_birthday
    date = Date.iso8601(birthday)
  rescue
    errors.add(:birthday, 'Invalid format, only formats YYYY-MM-DD and YYYYMMDD are allowed')
  end

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

  def sanitize_text
    self.name = name.titleize
    self.email = email.downcase
  end
end
