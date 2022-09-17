require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user_id: user.id) }
  
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
  #     sign_in user
  #     get post_path(post)
  #     expect(response).to have_http_status :ok
  #   end
  # end
end