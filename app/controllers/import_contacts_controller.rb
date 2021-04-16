class ImportContactsController < ApplicationController

  def new
    @import_contact = ImportContact.new
  end

  def index
    @imported_contacts = ImportContact.all
  end
  
  def import
    @import_contact = current_user.import_contacts.build(filename: params[:file].original_filename)
    @import_contact.save
    @import_contact.import_csv(params[:file], current_user)
    redirect_to contacts_path, alert: 'Contacts imported.'
  end


end
