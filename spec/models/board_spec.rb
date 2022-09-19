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
end