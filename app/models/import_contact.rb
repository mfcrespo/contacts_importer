class ImportContact < ApplicationRecord
  include AASM

  belongs_to :user
  validates_presence_of :filename, :state

  aasm column: 'state' do
    state :processing, initial: true
    state :waiting, :failed, :finished

    event :processing_file do
      transitions from: :waiting, to: :processing
    end

    event :finished_import do
      transitions from: :processing, to: :finished
    end

    event :failed_import do
      transitions from: :processing, to: :failed
    end
  end

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
        reject_contacts(user, contact, contact_hash)
 
      end
    end
  end

  def self.reject_contacts(user, contact, contact_hash)
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

