require 'rails_helper'
 
RSpec.describe "Users", type: :request do

  let!(:user) { create(:user) }

  # describe "GET /:id/profile" do
  #   it "正しいレスポンスを返すこと" do
  #     get profile_path
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
  # describe "GET /users" do
  #   it "正しいレスポンスを返すこと" do
  #     user = build(:user)
  #     sign_in_user
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

  describe "POST /register" do
    context '無効なユーザー登録' do
      it "無効なメール" do
        expect{
          post user_registration_path, params: { user: {name: 'hoge', email: 'hoge.com', password: 'password', password_confirmation: 'password' }}
        }.not_to change(User, :count)
      end

      it "無効なパスワード" do
        expect{
          post user_registration_path, params: { user: {name: 'hoge', email: 'hoge@example.com', password: 'passanger', password_confirmation: 'password' }}
        }.not_to change(User, :count)
      end
    end

    context '有効なユーザー登録' do
      let(:user_params) {{ user: {name: 'hoge', email: 'hoge@example.com', password: 'password', password_confirmation: 'password' }}}

      it '登録されること' do
        expect{
          post user_registration_path, params: user_params
        }.to change(User, :count).by 1
      end

      it 'リダイレクト(root)' do
        post user_registration_path, params: user_params
        expect(response).to redirect_to root_path
      end

      # it 'ログイン状態であること' do
      #   post user_session_path, params: user_params
      #   expect(signed_in?).to be_truthy
      # end

      it 'flashが表示されること' do
        post user_registration_path, params: user_params
        expect(flash).to be_any
      end
    end
  end

  # describe "GET /register/edit/profile" do
  #   it "正しいレスポンスを返すこと" do
  #     get edit_user_registration_path
  #     expect(response).to have_http_status(:ok)
  #   end
  # end


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