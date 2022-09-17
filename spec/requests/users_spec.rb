require 'rails_helper'
 
RSpec.describe "Users", type: :request do
  # describe "GET /:id/profile" do
  #   it "正しいレスポンスを返すこと" do
  #     get profile_path
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
  # describe "GET /users" do
  #   it "正しいレスポンスを返すこと" do
  #     get users_path
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
  # describe "GET /users/positions" do
  #   it "正しいレスポンスを返すこと" do
  #     get positions_path
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
  # describe "GET  /:id/unsubscribe" do
  #   it "正しいレスポンスを返すこと" do
  #     get unsubscribe_path
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
  # describe "GET  /:id/following" do
  #   it "正しいレスポンスを返すこと" do
  #     get following_path
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
  # describe "GET  /:id/followers" do
  #   it "正しいレスポンスを返すこと" do
  #     get followers_path
  #     expect(response).to have_http_status(:ok)
  #   end
  # end

  describe "GET /register/signup" do
    it "正しいレスポンスを返すこと" do
      get new_user_registration_path
      expect(response).to have_http_status(:ok)
    end
  end
  # describe "GET /register/edit/profile" do
  #   it "正しいレスポンスを返すこと" do
  #     get edit_user_registration_path
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
  describe "GET /login" do
    it "正しいレスポンスを返すこと" do
      get new_user_session_path
      expect(response).to have_http_status(:ok)
    end
  end
  # describe "DELETE /logout" do
  #   it "正しいレスポンスを返すこと" do
  #     delete destroy_user_session_path
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
  describe "GET /secret/new" do
    it "正しいレスポンスを返すこと" do
      get new_user_password_path
      expect(response).to have_http_status(:ok)
    end
  end
  # describe "GET /secret/edit" do
  #   it "正しいレスポンスを返すこと" do
  #     get edit_user_password_path
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
  describe "GET /verification/new" do
    it "正しいレスポンスを返すこと" do
      get new_user_confirmation_path
      expect(response).to have_http_status(:ok)
    end
  end
  describe "GET /verification" do
    it "正しいレスポンスを返すこと" do
      get user_confirmation_path
      expect(response).to have_http_status(:ok)
    end
  end

end