require 'rails_helper'

RSpec.describe Relationship, type: :model do
  subject(:relationship) { create(:relationship) }
  subject(:user) { create(:user, id: 1) }

  describe 'バリデーション' do
    it { should be_valid }
    it { should validate_presence_of :follower_id}
    it { should validate_presence_of :followed_id}
  end

  describe "アソシエーションテスト" do
    it { should belong_to(:follower) }
    it { should belong_to(:followed) }
  end
end
