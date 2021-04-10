class Contact < ApplicationRecord
  belongs_to :user
  before_save :sanitize_text
  NAME_REGEX_VALID = /\A[a-zA-Z\s-]+\z/

  validates_presence_of :name, :birthday, :phone, :address, :credit_card, :franchise, :email,
                         message: "can't be blank"

  validates :name, format: { with: NAME_REGEX_VALID, message: 'Name with special character arent allowed, only "-" is allowed' }
  validate :valid_birthday

  def valid_birthday
    date = Date.iso8601(birthday)
  end

  def self.import(file, user)
    CSV.foreach(file.path, headers: true) do |row|
      contact_hash = row.to_hash
      contact = find_or_create_by!(name: contact_hash['name'], 
                                    birthday: contact_hash['birthday'], 
                                    phone: contact_hash['phone'], 
                                    address: contact_hash['address'], 
                                    credit_card: contact_hash['credit_card'], 
                                    franchise: contact_hash['franchise'], 
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
