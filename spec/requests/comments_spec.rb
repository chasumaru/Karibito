require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user_id: user.id) }
  let!(:comment) { create(:comment, user_id: user.id, post_id: post.id) }

  describe 'GET /edit' do
    context'ログイン済みの正しいユーザーの場合' do
      before do
        user.confirm
        sign_in user
      end
      it '正しいレスポンスを返すこと' do
        get edit_post_comment_path(post, comment)
        expect(response).to have_http_status(:ok)
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        get edit_post_comment_path(post, comment)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  # Turbo Streamのフォーマット指定が必要
  # describe 'PATCH /update' do
  #   let(:comment_params) {{ comment: {title: 'sample', context: 'sample_context', user_id: user.id, post_id: post.id }}}
  #   context'ログイン済みの正しいユーザーの場合' do
  #     before do
  #       user.confirm
  #       sign_in user
  #     end
  #     it 'リダイレクトされること' do
  #       patch post_comment_path(post, comment), params: comment_params
  #       expect(response).to have_http_status(:ok)
  #     end

  #     it 'flashが表示されていること' do
  #       patch post_comment_path(post, comment), params: comment_params
  #       expect(flash).to be_any
  #     end
  #   end
  #   context 'ログインしていない場合' do
  #     it 'リダイレクトされること' do
  #       patch post_comment_path(post, comment), params: comment_params
  #       expect(response).to redirect_to new_user_session_path
  #     end
  #   end
  # end
end
