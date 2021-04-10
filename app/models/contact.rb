class Contact < ApplicationRecord
  belongs_to :user

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
end
