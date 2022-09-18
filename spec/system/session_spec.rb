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

    context '有効な値の場合' do
      let(:user) { create(:user) }
      it 'flashメッセージが表示される' do
        visit root_path
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        find('#login_btn').click
        # expect(response).to redirect_to root_path
        # expect(flash[:notice]).to match('ログインしました。')
        # expect(page).to_not have_selector "a[href=\"#{new_user_session_path}\"]"
        # expect(page).to have_selector "a[href=\"#{profile_path(:user)}\"]"
        # expect(page).to have_selector "a[href=\"#{edit_user_registration_path(user)}\"]"
      
      end
    end
  end
end