require "rails_helper"

RSpec.describe BorrowedRequest, type: :model do
  describe "associations" do
    it {should belong_to(:user)}
  end

  describe "scopes" do
    let!(:user) {FactoryBot.create :user}
    let!(:request_1) {FactoryBot.create :borrowed_request, user_id: user.id, status: 1}
    let!(:request_2) {FactoryBot.create :borrowed_request, user_id: user.id}

    context "order by status" do
      it "should be order by status" do
        expect(BorrowedRequest.order_status).to eq [request_2, request_1]
      end
    end
  end

  describe "delegates" do
    let!(:user) {FactoryBot.create :user}
    let!(:request) {FactoryBot.create :borrowed_request, user_id: user.id}

    context "user's name" do
      it "should return user's name" do
        expect(request.user_name).to eq request.user.name
      end
    end
  end

  describe "enums" do
    it {should define_enum_for(:status).with_values(requested: 0, borrowing: 1, returned: 2, rejected: 3)}
  end

  describe "handle request" do
    let!(:user) {FactoryBot.create :user}
    let!(:request) {FactoryBot.create :borrowed_request, user_id: user.id}
    let!(:category) {FactoryBot.create :category, parent_id: nil}
    let!(:publisher) {FactoryBot.create :publisher}
    let!(:author) {FactoryBot.create :author}
    let!(:book) {FactoryBot.create :book,
                                   category_id: category.id, publisher_id: publisher.id, author_id: author.id}
    let!(:book_request) {FactoryBot.create :book_request, book_id: book.id, borrowed_request_id: request.id}

    context "accept request" do
      before do
        request.accept_request
      end

      it "should borrowing" do
        expect(request.borrowing?).to eq true
      end

      it "should decrease book amount" do
        expect(book.amount).to eq 1
      end
    end

    context "reject request" do
      before do
        request.reject_request
      end

      it "should rejected" do
        expect(request.rejected?).to eq true
      end
    end

    context "return request" do
      before do
        request.return_request
      end

      it "should returned" do
        expect(request.returned?).to eq true
      end

      it "should increase book amount" do
        expect(book.amount).to eq 2
      end
    end
  end
end
