require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /index" do
    it "正常にレスポンスを返すこと" do
      get boards_path
      expect(response).to have_http_status :ok
    end
  end

  describe "GET /new" do
    it "正常にレスポンスを返すこと" do
      get new_board_path
      expect(response).to have_http_status :ok
    end
  end

  # describe "GET /show" do
  #   it "正常にレスポンスを返すこと" do
  #     get "/boards/show"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /edit" do
  #   it "正常にレスポンスを返すこと" do
  #     get "/boards/edit"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end