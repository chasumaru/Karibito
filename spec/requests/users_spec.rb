require 'rails_helper'

RSpec.describe "Users", type: :request do

  let!(:user) { create(:user) }

  describe "GET /:id/profile" do
    subject { get profile_path(user) }
    context 'ログインしている場合' do
      before do
        user.confirm  
        sign_in user
      end
      it "正しいレスポンスを返すこと" do
        get profile_path(user)
        expect(response).to have_http_status(:ok)
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        get profile_path(user)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET /users" do
    subject { get users_path }
    context 'ログインしている場合' do
      before do
        user.confirm
        sign_in user
      end
      it "正しいレスポンスを返すこと" do
        get users_path
        expect(response).to have_http_status(:ok)
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        get users_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET  /:id/unsubscribe" do
    subject { get unsubscribe_path(user) }
    context 'ログインしている場合' do
      before do
        user.confirm
        sign_in user
      end
      it "正しいレスポンスを返すこと" do
        get unsubscribe_path(user)
        expect(response).to have_http_status(:ok)
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        get unsubscribe_path(user)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET  /:id/following" do
    subject { get following_path(user) }
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

  describe "GET  /:id/followers" do
    subject { get followers_path(user) }
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

  describe "GET /users/positions" do
    it "正しいレスポンスを返すこと" do
      get positions_path
      expect(response).to have_http_status(:ok)
    end
  end

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

      it 'flashが表示されること' do
        post user_registration_path, params: user_params
        expect(flash).to be_any
      end
    end
  end

  describe "GET /register/edit/profile" do
    context 'ログインしている場合' do
      before do
        user.confirm
        sign_in user
      end
      it "正しいレスポンスを返すこと" do
        get edit_user_registration_path(user)
        expect(response).to have_http_status(:ok)
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        get edit_user_registration_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end


  describe "DELETE /logout" do
    subject { delete destroy_user_session_path }
    context 'ログインしている場合' do
      before do
        user.confirm
        sign_in user
      end
      it "ログアウトする" do
        delete destroy_user_session_path
        expect(response).to redirect_to root_path
      end
    end
  end


  describe "GET /secret/new" do
    it "正しいレスポンスを返すこと" do
      get new_user_password_path
      expect(response).to have_http_status(:ok)
    end
    subject { get new_user_password_path(user) }
    context 'ログインしている場合' do
      before do
        user.confirm
        sign_in user
      end
      it "正しいレスポンスを返すこと" do
        get new_user_password_path(user)
        expect(response).to have_http_status(:ok)
      end
    end
  end
  
  describe "GET /secret/edit" do
    context 'ログインしている場合' do
      before do
        user.confirm
        sign_in user
      end
      it "正しいレスポンスを返すこと" do
        get edit_user_password_path(user)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

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