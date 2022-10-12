require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { create(:user) }
  let!(:board) { create(:board, user_id: user.id) }
  # let!(:anonymous_board) { create(:board) }

  describe 'GET /index' do
    it '正常にレスポンスを返すこと' do
      get boards_path
      expect(response).to have_http_status :ok
    end
  end

  describe 'GET /new' do
    it '正常にレスポンスを返すこと' do
      get new_board_path
      expect(response).to have_http_status :ok
    end
  end

  describe 'GET /show' do
    it '正しいレスポンスを返すこと' do
      get board_path(board)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /edit' do
    context'ログイン済みの正しいユーザーの場合' do
      before do
        user.confirm
        sign_in user
      end
      it '正しいレスポンスを返すこと' do
        get edit_board_path(board)
        expect(response).to have_http_status(:ok)
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        get edit_board_path(board)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH /update' do
    let(:board_params) {{ board: {title: 'sample', description: 'sample_description' }}}
    context'ログイン済みの正しいユーザーの場合' do
      before do
        user.confirm
        sign_in user
      end
      it 'リダイレクトされること' do
        patch board_path(board), params: board_params
        expect(response).to redirect_to board_path(board)
      end

      it 'flashが表示されていること' do
        patch board_path(board), params: board_params
        expect(flash).to be_any
      end
    end
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        patch board_path(board), params: board_params
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE /destroy' do
    let(:board_params) {{ board: {title: 'sample', description: 'sample_description' }}}
    context'ログイン済みの正しいユーザーの場合' do
      before do
        user.confirm
        sign_in user
      end
      it '削除されること' do
        expect{
          delete board_path(board), params: board_params
        }.to change(Board, :count).by -1
      end

      it 'flashが表示されていること' do
        delete board_path(board), params: board_params
        expect(flash).to be_any
      end

      it 'リダイレクトされること' do
        delete board_path(board), params: board_params
        expect(response).to redirect_to boards_path
      end
    end

    context 'ログインしていない場合' do
      it '削除できないこと' do
        expect{
          delete board_path(board), params: board_params
        }.not_to change(Board, :count)
      end

      it 'リダイレクトされること' do
        delete board_path(board), params: board_params
        expect(response).to redirect_to new_user_session_path
      end
    end
  end


end
