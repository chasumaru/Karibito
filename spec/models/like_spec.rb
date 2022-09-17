require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'モデルのテスト' do
    it "有効なuserの場合は保存されるか" do
      expect(build(:like)).to be_valid
    end
  end
end
