class ContactsImporterJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: true

  def perform(file_path, current_user_id, filename, remote_headers)
    current_user = User.find_by(id: current_user_id)
    @import_contact = current_user.import_contacts.build(filename: filename, state: '')
    @import_contact.save    
    @import_contact.import_csv(file_path, current_user, remote_headers)
  end
end
