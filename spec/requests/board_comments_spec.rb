require 'rails_helper'

RSpec.describe "BoardComments", type: :request do
  let!(:user) { create(:user) }
  let!(:board) { create(:board, user_id: user.id) }
  let!(:board_comment) { create(:board_comment, user_id: user.id, board_id: board.id) }

  describe "GET /edit" do
    context'ログイン済みの正しいユーザーの場合' do
      before do
        user.confirm
        sign_in user
      end
      it "正しいレスポンスを返すこと" do
        get edit_board_board_comment_path(board, board_comment)
        expect(response).to have_http_status(:ok)
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        get edit_board_board_comment_path(board, board_comment)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
