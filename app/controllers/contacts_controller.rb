class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
  end


  def import
    Contact.import(params[:file], current_user)
    redirect_to contacts_index_path, notice: 'Contacts imported.'
  end
end
