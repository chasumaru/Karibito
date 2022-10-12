require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { build(:like) }
  subject(:like) { create(:like) }

  describe 'バリデーション' do
    it { should be_valid }
  end


  describe "アソシエーションテスト" do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
