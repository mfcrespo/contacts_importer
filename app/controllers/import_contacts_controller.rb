class ImportContactsController < ApplicationController
  before_action :authenticate_user!

  def new
    @import_contacts = ImportContact.new
    @import_contact = ImportContact.all
  end

  def index
    @imported_contacts = ImportContact.all.paginate(page: params[:page], per_page: 10)
  end
  
  def import
    ContactsImporterJob.perform_later
    redirect_to contacts_path, alert: 'Contacts imported.'
  end

end
