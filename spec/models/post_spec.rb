require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build(:post) }
  subject(:post) { create(:post) }

  describe 'バリデーション' do
    it { should be_valid }
    it { should validate_presence_of :user_id}
    it { should validate_presence_of :title}
    it { should validate_length_of(:title).is_at_most(50)}
    it { should validate_length_of(:content).is_at_most(400)}
  end

  describe "アソシエーションテスト" do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:liked_users) }
    it { should have_many(:notifications) }
    it { should have_many_attached(:images) }
    it { should have_many(:tags) }
  end

  describe '関連付けされたモデルのdependentオプション' do

    describe 'Comment' do
      let(:comment) { create(:comment) }
      it '投稿が削除された場合、その投稿のコメントも削除されること' do
        user = comment.user
        expect {
          user.destroy
        }.to change(Comment, :count).by (-1)
      end
    end

    describe 'Like' do
      let(:like) { create(:like) }
      it '投稿が削除された場合、その投稿のいいねも削除されること' do
        user = like.user
        expect {
          user.destroy
        }.to change(Like, :count).by (-1)
      end
    end
  end
end