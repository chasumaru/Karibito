require 'rails_helper'

RSpec.describe Relationship, type: :model do
  subject(:relationship) { create(:relationship, follower_id: other.id, followed_id: user.id) }
  let(:user) { create(:user) }
  let(:other) { create(:user) }

  describe 'バリデーション' do
    it { should be_valid }
    it { should validate_presence_of :follower_id}
    it { should validate_presence_of :followed_id}
  end

  describe "アソシエーションテスト" do
    it { should belong_to(:follower) }
    it { should belong_to(:followed) }
  end

  describe "followとunfollow機能テスト" do
    it "should follow and unfollow a user" do
      expect(user.following?(other)).to be_falsy
      user.follow(other)
      expect(user.following?(other)).to be_truthy
      expect(other.followers.include?(user)).to be_truthy
      user.unfollow(other)
      expect(user.following?(other)).to be_falsy
    end
  end
end
