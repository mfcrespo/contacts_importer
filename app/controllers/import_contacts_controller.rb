class ImportContactsController < ApplicationController

  def new
    @import_contact = ImportContact.new
  end

  def index
    @imported_contacts = ImportContact.all
  end
  
  def import
    ImportContact.import_csv(params[:file], current_user)
    @import_contact = current_user.import_contacts.build(filename: params[:file].original_filename)
    if @import_contact.save
      redirect_to contacts_path, alert: 'Contacts imported.'
    else
      flash.now[:alert] = 'The file hasn´t been created.'
    end
  end


end
