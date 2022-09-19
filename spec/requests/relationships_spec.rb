require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  let(:relationship) { create(:relationship, follower_id: other.id, followed_id: user.id) }
  let(:user) { FactoryBot.create(:user) }
  let(:other) { FactoryBot.create(:user) }


  describe "GET  /:id/followers" do
    context 'ログインしている場合' do
      before do
        user.confirm
        sign_in user
      end
      it "正しいレスポンスを返すこと" do
        get followers_path(user)
        expect(response).to have_http_status(:ok)
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        get followers_path(user)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET  /:id/following" do
    context 'ログインしている場合' do
      before do
        user.confirm
        sign_in user
      end
      it "正しいレスポンスを返すこと" do
        get following_path(user)
        expect(response).to have_http_status(:ok)
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        get following_path(user)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
