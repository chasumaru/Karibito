require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:other) { build(:user) }
  subject(:user) { create(:user) }

  describe 'ユーザー登録' do
    it { should be_valid }
    it { should validate_presence_of :name}
    it { should validate_length_of(:name).is_at_most(30)}
    it { should validate_presence_of :email}
    it { should validate_length_of :email}
    it { should validate_presence_of :password}
    it { should validate_length_of(:password).is_at_least(6).is_at_most(32)}

    it 'emailが有効な形式であること' do
      valid_addresses = %w[user@exmple.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end

    it 'emailは重複して登録できないこと' do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save
      expect(duplicate_user).not_to be_valid
    end

    it 'emailは小文字でDB登録されていること' do
      upcase_email = user.email.upcase
      user.email = upcase_email
      user.save
      expect(user.reload.email).to eq upcase_email.downcase
    end
  end

  describe 'ユーザー編集' do
    it { should validate_length_of(:profile).is_at_most(200)}
  end

  describe "アソシエーションテスト" do
    it { should have_many(:active_relationships) }
    it { should have_many(:passive_relationships) }
    it { should have_many(:following) }
    it { should have_many(:followers) }
    it { should have_many(:posts) }
    it { should have_many(:likes) }
    it { should have_many(:liked_posts) }
    it { should have_many(:comments) }
    it { should have_many(:boards) }
    it { should have_many(:board_comments) }
    it { should have_many(:positions) }
    it { should have_many(:active_notifications) }
    it { should have_many(:passive_notifications) }
    it { should have_one_attached(:avatar) }
    it { should have_one_attached(:background) }
  end

  describe '関連付けされたモデルのdependentオプション' do
    describe 'Post' do
      let(:post) { create(:post) }
      it 'ユーザが削除された場合、そのユーザの投稿も削除されること' do
        user = post.user
        expect {
          user.destroy
        }.to change(Post, :count).by (-1)
      end
    end

    describe 'Comment' do
      let(:comment) { create(:comment) }
      it 'ユーザが削除された場合、そのユーザのコメントも削除されること' do
        user = comment.user
        expect {
          user.destroy
        }.to change(Comment, :count).by (-1)
      end
    end

    describe 'Like' do
      let(:like) { create(:like) }
      it 'ユーザが削除された場合、そのユーザのいいねも削除されること' do
        user = like.user
        expect {
          user.destroy
        }.to change(Like, :count).by (-1)
      end
    end
  end
end