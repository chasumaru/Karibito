require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build(:post) }
  subject(:post) { create(:post) }

  describe 'ユーザー登録' do
    it { should be_valid }
    it { should validate_presence_of :user_id}
    it { should validate_presence_of :title}
    it { should validate_length_of(:title).is_at_most(50)}
    it { should validate_length_of(:content).is_at_most(300)}
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
end