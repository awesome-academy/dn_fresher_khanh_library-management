require "rails_helper"
include SessionsHelper

RSpec.describe Admin::BorrowedRequestsController, type: :controller do
  describe "GET index" do
    let!(:admin) {FactoryBot.create :user, role: 1}
    let!(:user) {FactoryBot.create :user}
    let!(:request_1) {FactoryBot.create :borrowed_request, user_id: user.id}
    let!(:request_2) {FactoryBot.create :borrowed_request, user_id: user.id}

    context "when admin" do
      before do
        log_in admin
        get :index
      end

      it "should render index" do
        expect(response).to render_template :index
      end

      it "should right requests" do
        expect(assigns(:requests)).to eq [request_2, request_1]
      end
    end

    context "when not admin" do
      before do
        log_in user
        get :index
      end

      it "should flash warning" do
        expect(flash[:warning]).to eq I18n.t "flash.borrowed_request.not_admin"
      end

      it "should render root" do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "PUT handle_status" do
    let!(:admin) {FactoryBot.create :user, role: 1}
    let!(:user) {FactoryBot.create :user}
    let!(:request) {FactoryBot.create :borrowed_request, user_id: user.id}

    context "when success" do
      before do
        log_in admin
        put :handle_status, params: {id: request.id, name: "accept"}
      end

      it "should flash success" do
        expect(flash[:success]).to eq I18n.t "flash.borrowed_request.accept_success"
      end

      # it "should reload" do
      #   expect(response).to redirect_to admin_borrowed_requests_path
      # end
    end

    context "when not find request" do
      before do
        log_in admin
        put :handle_status, params: {id: -1, name: "accept"}
      end

      it "should flash warning" do
        expect(flash[:warning]).to eq I18n.t "flash.borrowed_request.not_found"
      end

      # it "should reload" do
      #   expect(response).to redirect_to admin_borrowed_requests_path
      # end
    end

    context "when not admin" do
      before do
        log_in user
        put :handle_status, params: {id: request.id, name: "accept"}
      end

      it "should flash warning" do
        expect(flash[:warning]).to eq I18n.t "flash.borrowed_request.not_admin"
      end

      # it "should render root" do
      #   expect(response).to redirect_to(root_path)
      # end
    end
  end
end
