class RejectedContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rejected_contacts = RejectedContact.all.paginate(page: params[:page], per_page: 10)
  end
end
