require 'rails_helper'
 
RSpec.describe "Layouts", type: :system do
  before do
    driven_by(:rack_test)
  end
 
  let(:user) { create(:user) }
 
  describe 'navbar' do

    context 'ログインしていない場合' do
      before do
        visit root_path
      end

      it 'titleをクリックするとrootに遷移すること' do
        click_link 'Karibito'
        expect(page.current_path).to eq root_path
      end

      it 'ロゴをクリックするとrootに遷移すること' do
        click_link 'Logo'
        expect(page.current_path).to eq root_path
      end

      it 'サービス概要' do
        click_button 'サービス概要'
        expect(page.current_path).to eq about_path
      end
  
      it 'ヘルプ' do
        click_button 'ヘルプ'
        expect(page.current_path).to eq faq_path
      end

      it 'お問い合わせ' do
        expect(page).to have_link 'お問い合わせ', href: "https://forms.gle/Z8WNE7HpJw3NnH8F6"
      end

      it '会員登録' do
        click_link 'nav_signup'
        expect(page.current_path).to eq new_user_registration_path
      end

      it 'ログイン' do
        click_link 'nav_login'
        expect(page.current_path).to eq new_user_session_path
      end
    end

    context 'ログイン済みの場合' do
      before do
        user.confirm
        sign_in user
        visit root_path
      end

      it 'ログアウト' do
        # click_button 'ログアウト'
        # # 確認ダイアログの処理
        # expect(page.current_path).to eq root_path
        expect(page).to have_content "ログアウト"
      end

      it '通知一覧' do
        click_button 'View notifications'
        expect(page.current_path).to eq notifications_path
      end

      it 'マイページ' do
        click_link 'nav_mypage'
        expect(page.current_path).to eq profile_path(user)
      end
  
      it 'ユーザー編集' do
        click_link 'nav_edit_profile'
        expect(page.current_path).to eq edit_user_registration_path
      end
    end
  end


  describe 'sidebar' do
    context 'ログインしていない場合' do
      before do
        visit root_path
      end

      it '会員登録' do
        click_link 'side_signup'
        expect(page.current_path).to eq new_user_registration_path
      end

      it 'ログイン' do
        click_link 'side_login'
        expect(page.current_path).to eq new_user_session_path
      end

      it 'Karibitoとは?' do
        click_link 'side_about'
        expect(page.current_path).to eq about_path
      end

      it 'ヘルプセンター' do
        click_link 'ヘルプセンター'
        expect(page.current_path).to eq faq_path
      end

      it '利用規約' do
        click_link 'side_term'
        expect(page.current_path).to eq term_path
      end

      it 'プライバシーポリシー' do
        click_link 'side_privacy'
        expect(page.current_path).to eq privacy_path
      end

      it 'お問い合わせ' do
        expect(page).to have_link 'お問い合わせ', href: "https://forms.gle/Z8WNE7HpJw3NnH8F6"
      end
    end

     context 'ログイン済みの場合' do
      before do
        user.confirm
        sign_in user
        visit root_path
      end

      it 'マイページ' do
        click_link 'side_mypage'
        expect(page.current_path).to eq profile_path(user)
      end

      it '通知一覧' do
        click_link '通知一覧'
        expect(page.current_path).to eq notifications_path
      end

      it 'ユーザー編集' do
        click_link 'side_edit_profile'
        expect(page.current_path).to eq edit_user_registration_path
      end

      it 'ログアウト' do
        # click_button 'ログアウト'
        # # 確認ダイアログの処理
        # expect(page.current_path).to eq root_path
        expect(page).to have_content "ログアウト"
      end
    end
  end
end
