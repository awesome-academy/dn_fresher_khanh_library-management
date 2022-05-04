class Admin::BorrowedRequestsController < ApplicationController
  load_and_authorize_resource

  def index
    @pagy, @requests = pagy BorrowedRequest.order_status,
                            items: Settings.pagy.requests_items
  end

  def handle_status
    name = params.require(:name)
    begin
      @borrowed_request.send "#{name}_request"
      flash[:success] = t "flash.borrowed_request.#{name}_success"
    rescue StandardError
      flash[:warning] = t "flash.borrowed_request.#{name}_fail"
    ensure
      redirect_to admin_borrowed_requests_url
    end
  end
end
