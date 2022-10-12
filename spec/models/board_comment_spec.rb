require 'rails_helper'

RSpec.describe BoardComment, type: :model do
  let(:board_comment) { build(:board_comment) }
  subject(:board_comment) { create(:board_comment) }

  describe 'バリデーション' do
    it { should be_valid }
    it { should validate_presence_of :description}
    it { should validate_length_of(:description).is_at_most(300)}
  end


  describe "アソシエーションテスト" do
    it { should belong_to(:board) }
  end
end
