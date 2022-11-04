require 'rails_helper'
 
RSpec.describe "Registration", type: :system do
  before do
    driven_by(:rack_test)
  end
 
  describe '#new' do
    context '無効な値の場合' do
      it 'flashメッセージが表示される' do
        visit new_user_registration_path
        fill_in 'ユーザー名', with: 'invlid'
        fill_in 'メールアドレス', with: '@invlid'
        fill_in 'パスワード', with: 'foo'
        click_button '無料登録する'
        expect(page).to have_selector 'div#error_explanation'
        visit new_user_registration_path
      end
    end
  end
end