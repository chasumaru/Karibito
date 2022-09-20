require 'rails_helper'

RSpec.describe Board, type: :model do
  let(:board) { build(:board) }
  subject(:board) { create(:board) }

  describe 'バリデーション' do
    it { should be_valid }
    it { should validate_presence_of :title}
    it { should validate_length_of(:title).is_at_most(100)}
    it { should validate_length_of(:description).is_at_most(400)}
  end

  describe "アソシエーションテスト" do
    it { should have_many(:board_comment) }
    it { should have_one_attached(:illustration) }
    it { should have_many(:tags) }
  end

  describe '関連付けされたモデルのdependentオプション' do
    describe 'BoardComment' do
      let(:board_comment) { create(:board_comment) }
      it '掲示板が削除された場合、その掲示板の掲示板コメントも削除されること' do
        board = board_comment.board
        expect {
          board.destroy
        }.to change(BoardComment, :count).by (-1)
      end
    end
  end
end