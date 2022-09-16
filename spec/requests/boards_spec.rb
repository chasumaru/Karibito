require 'rails_helper'

RSpec.describe "Boards", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/boards"
      expect(response).to have_http_status :ok
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/boards/new"
      expect(response).to have_http_status :ok
    end
  end

  # describe "GET /show" do
  #   it "returns http success" do
  #     get "/boards/show"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /edit" do
  #   it "returns http success" do
  #     get "/boards/edit"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
