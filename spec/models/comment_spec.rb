require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { build(:comment) }
  subject(:comment) { create(:comment) }

  describe 'バリデーション' do
    it { should be_valid }
    it { should validate_presence_of :context}
    it { should validate_length_of(:context).is_at_most(300)}
  end


  describe "アソシエーションテスト" do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
    it { should have_many(:replies) }
  end
end