require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let!(:user) { create(:user) }

  describe "GET /index" do
    context 'ログインしている場合' do
      before do
        user.confirm
        sign_in user
      end
      it "正しいレスポンスを返すこと" do
        get notifications_path
        expect(response).to have_http_status(:ok)
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        get notifications_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
