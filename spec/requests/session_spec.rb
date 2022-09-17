require 'rails_helper'
 
RSpec.describe "Sessions", type: :request do
  describe "GET /login" do
    it "正しいレスポンスを返すこと" do
      get new_user_session_path
      expect(response).to have_http_status(:ok)
    end
  end
end