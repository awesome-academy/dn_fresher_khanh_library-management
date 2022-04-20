class Admin::BorrowedRequestsController < ApplicationController
  before_action :admin_user
  before_action :load_request, except: :index

  def index
    @pagy, @requests = pagy BorrowedRequest.order_status,
                            items: Settings.pagy.requests_items
  end

  def handle_status
    name = params.require(:name)
    begin
      @request.send "#{name}_request"
      flash[:success] = t "flash.borrowed_request.#{name}_success"
    rescue StandardError
      flash[:warning] = t "flash.borrowed_request.#{name}_fail"
    ensure
      redirect_to admin_borrowed_requests_url
    end
  end

  private

  def load_request
    @request = BorrowedRequest.find_by id: params.require(:id)
    return if @request

    flash[:warning] = t "flash.borrowed_request.not_found"
    redirect_to admin_borrowed_requests_url
  end

  def admin_user
    return if current_user&.admin?

    flash[:warning] = t "flash.borrowed_request.not_admin"
    redirect_to root_url
  end
end
