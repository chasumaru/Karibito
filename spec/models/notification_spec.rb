require 'rails_helper'

RSpec.describe Notification, type: :model do
  subject(:notification) { create(:notification) }

  describe 'バリデーション' do
    it { should be_valid }
  end
end
