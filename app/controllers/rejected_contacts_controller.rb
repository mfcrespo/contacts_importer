class RejectedContactsController < ApplicationController

  def index
    @rejected_contacts = RejectedContact.all.paginate(page: params[:page], per_page: 20)
  end
end
