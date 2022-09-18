require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user_id: user.id) }
  
  describe "GET /index" do
    it "正常にレスポンスを返すこと" do
      get posts_path
      expect(response).to have_http_status :ok
    end
  end

  describe "GET /new" do
    context 'ログインしている場合' do
      before do
        user.confirm  
        sign_in user
      end
      it "正しいレスポンスを返すこと" do
        get new_post_path
        expect(response).to have_http_status(:ok)
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        get new_post_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET /show" do
    it "正しいレスポンスを返すこと" do
      get post_path(post)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /edit" do
    context'ログイン済みの正しいユーザーの場合' do
      before do
        user.confirm
        sign_in user
      end
      it "正しいレスポンスを返すこと" do
        get edit_post_path(post)
        expect(response).to have_http_status(:ok)
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        get edit_post_path(post)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "PATCH /update" do
    let(:post_params) {{ post: {title: 'sample', content: 'sample_content' }}}
    context'ログイン済みの正しいユーザーの場合' do
      before do
        user.confirm
        sign_in user
      end
      it "更新する" do
        patch post_path(post), params: post_params
        expect(response).to redirect_to post_path(post)
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        patch post_path(post), params: post_params
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  
  describe "DELETE /destroy" do
    let(:post_params) {{ post: {title: 'sample', content: 'sample_content' }}}
    context'ログイン済みの正しいユーザーの場合' do
      before do
        user.confirm
        sign_in user
      end
      it "削除されること" do
        expect{
          delete post_path(post), params: post_params
        }.to change(Post, :count).by -1
      end

      it "リダイレクトされること" do
        delete post_path(post), params: post_params
        expect(response).to redirect_to posts_path
      end
    end

    context 'ログインしていない場合' do
      it '削除できないこと' do
        expect{
          delete post_path(post), params: post_params
        }.not_to change(Post, :count)
      end

      it 'リダイレクトされること' do
        delete post_path(post), params: post_params
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end