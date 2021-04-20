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
    file_path = '/tmp/contacts.csv'
    File.binwrite(file_path, params[:file].read)
    remote_headers = params.to_unsafe_hash.select { |key,value| key.match(/name|birthday|phone|address|credit_card|email/) }
    ContactsImporterJob.perform_later(file_path, current_user.id, params[:file].original_filename, remote_headers)
    redirect_to contacts_path, alert: 'Contacts imported.'
  end

end
