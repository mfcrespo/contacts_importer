class ImportContact < ApplicationRecord
  include AASM
  
  default_scope {order("created_at DESC")}
  belongs_to :user
  validates_presence_of :filename, :state

  aasm column: 'state' do
    state :waiting, initial: true
    state :processing, :failed, :finished

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

    

  def import_csv(file, user, remote_headers)
    CSV.foreach(file, headers: true) do |row|
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
      contact.assign_attributes(Contact.headers_pair(user, contact_hash, remote_headers))  
      processing_file! if may_processing_file?
      if contact.save && may_finished_import?
        finished_import!
      else
        reject_contacts!(user, contact, contact_hash, remote_headers)
 
      end
    end
  end

  def reject_contacts!(user, contact, contact_hash, remote_headers)
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
                                          user_id: user.id)
    rejected_contact.assign_attributes(Contact.headers_pair(user, contact_hash, remote_headers))               
    rejected_contact.error = errors                                      
    processing_file! if may_processing_file?
    rejected_contact.save!
    failed_import! if may_failed_import?
  end

  
end

