class ContactsImporterJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform(*args)
    @import_contact = current_user.import_contacts.build(filename: params[:file].original_filename, state: '')
    @import_contact.save
    @import_contact.import_csv(params[:file], current_user)
  end
end
