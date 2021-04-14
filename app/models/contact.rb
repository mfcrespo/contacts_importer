class Contact < ApplicationRecord
  belongs_to :user
  before_save :sanitize_text
  NAME_REGEX_VALID = /\A[a-zA-Z\s-]+\z/
  PHONE_REGEX_VALID = /\(\+\d{2}\)\s\d{3}\s\d{3}\s\d{2}\s\d{2}|\(\+\d{2}\)\s\d{3}\-\d{3}\-\d{2}\-\d{2}/

  validates_presence_of :name, :birthday, :phone, :address, :credit_card, :last_digits, :franchise, :email,
                         message: "can't be blank"

  validates :name, format: { with: NAME_REGEX_VALID, message: 'Name with special character arent allowed, only "-" is allowed' }
  validate :valid_birthday
  validates :phone, format: { with: PHONE_REGEX_VALID, message: 'Please include de phone in the next formats: (+57) 320 432 05 09 or (+57) 320-432-05-09'}
  validates :email, email: true, uniqueness: { scope: :user_id, message: "You have a contact with the same email" }
  validate :digits
  after_validation :card_encrypted

  def valid_birthday
    date = Date.iso8601(birthday)
  end

  def digits
    self.last_digits = CreditCard.new(last_digits).credit_card_digits
  end 

  def card_encrypted
    self.credit_card = CreditCard.new(credit_card).encrypted
  end

  def self.import(file, user)
    CSV.foreach(file.path, headers: true) do |row|
      contact_hash = row.to_hash
      contact = find_or_create_by!(name: contact_hash['name'], 
                                    birthday: contact_hash['birthday'], 
                                    phone: contact_hash['phone'], 
                                    address: contact_hash['address'], 
                                    credit_card: contact_hash['credit_card'],
                                    last_digits: contact_hash['credit_card'],
                                    franchise: CreditCardValidations::Detector.new(contact_hash['credit_card']).brand_name, 
                                    email: contact_hash['email'],
                                    user_id: user.id)
      contact.update(contact_hash)
    end
  end

  def sanitize_text
    self.name = name.titleize
    self.email = email.downcase
  end
end
