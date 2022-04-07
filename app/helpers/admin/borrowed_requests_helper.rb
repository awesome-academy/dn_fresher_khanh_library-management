module Admin::BorrowedRequestsHelper
  def disabled_accept? request
    request.book_requests.each do |book_request|
      return true if book_request.book_amount < book_request.amount
    end
    false
  end
end
