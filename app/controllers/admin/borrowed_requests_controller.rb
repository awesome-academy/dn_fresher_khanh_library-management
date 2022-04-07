class Admin::BorrowedRequestsController < ApplicationController
  before_action :admin_user, only: :index

  def index
    @pagy, @requests = pagy BorrowedRequest.order_status,
                            items: Settings.pagy.requests_items
  end

  private

  def admin_user
    return if current_user.role

    flash[:warning] = t "flash.borrowed_request.not_admin"
    redirect_to root_url
  end
end
