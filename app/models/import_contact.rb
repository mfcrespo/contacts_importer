class ImportContact < ApplicationRecord

  belongs_to :user
  validates_presence_of :filename, :status

  def self.import_csv(file, user)
    CSV.foreach(file.path, headers: true) do |row|
      contact_hash = row.to_hash
      contact = Contact.new(name: contact_hash['name'], 
                                    birthday: contact_hash['birthday'], 
                                    phone: contact_hash['phone'], 
                                    address: contact_hash['address'], 
                                    credit_card: contact_hash['credit_card'],
                                    last_digits: contact_hash['credit_card'],
                                    franchise: contact_hash['credit_card'], 
                                    email: contact_hash['email'],
                                    user_id: user.id)
      if contact.save
        saved
      else
        errors = []
        errors = contact.errors.full_messages.join(', ')
        rejected_contact = RejectedContact.new(name: contact_hash['name'], 
                                              birthday: contact_hash['birthday'], 
                                              phone: contact_hash['phone'], 
                                              address: contact_hash['address'], 
                                              credit_card: contact_hash['credit_card'],
                                              last_digits: contact_hash['credit_card'],
                                              franchise: contact_hash['credit_card'], 
                                              email: contact_hash['email'],
                                              user_id: user.id, error: errors)
        rejected_contact.save
      end
    end
  end
end

