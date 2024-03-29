require 'rails_helper'
 
RSpec.describe "Sessions", type: :system do
  before do
    driven_by(:rack_test)
  end
 
  describe '#new' do
    context '無効な値の場合' do
      it 'flashメッセージが表示される' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: '@invlid'
        fill_in 'パスワード', with: 'foo'
        find('#login_btn').click
        expect(page).to have_selector 'div.alert'
        visit new_user_session_path
        expect(page).not_to have_selector 'div.alert'
      end
    end
  end
end