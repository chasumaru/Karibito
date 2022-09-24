require 'rails_helper'
 
RSpec.describe 'Layouts', type: :system do
  before do
    driven_by(:rack_test)
  end
 
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
 
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
        expect(page).to have_link 'お問い合わせ', href: 'https://forms.gle/Z8WNE7HpJw3NnH8F6'
      end

      it '会員登録' do
        click_link 'nav_signup'
        expect(page.current_path).to eq new_user_registration_path
      end

      it 'ログイン' do
        click_link 'nav_login'
        expect(page.current_path).to eq new_user_session_path
      end

      it '狩猟日記' do
        click_button 'posts_index'
        expect(page.current_path).to eq posts_path
      end

      it '狩猟掲示板' do
        click_button 'boards_index'
        expect(page.current_path).to eq boards_path
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
        expect(page).to have_content 'ログアウト'
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
        expect(page).to have_link 'お問い合わせ', href: 'https://forms.gle/Z8WNE7HpJw3NnH8F6'
      end

      it '会員登録' do
        click_link 'side_signup'
        expect(page.current_path).to eq new_user_registration_path
      end

      it 'ログイン' do
        click_link 'side_login'
        expect(page.current_path).to eq new_user_session_path
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
        expect(page).to have_content 'ログアウト'
      end
    end
  end

  describe 'footer' do
    context 'ログインしていない場合' do
      before do
        visit root_path
      end

      it '狩猟日記' do
        click_link '狩猟日記'
        expect(page.current_path).to eq posts_path
      end

      it '狩猟掲示板' do
        click_link '狩猟掲示板'
        expect(page.current_path).to eq boards_path
      end

      it 'スレを立てる' do
        click_link 'スレを立てる'
        expect(page.current_path).to eq new_board_path
      end

      it 'Karibitoとは?' do
        click_link 'footer_about'
        expect(page.current_path).to eq about_path
      end

      it '利用規約' do
        click_link 'footer_term'
        expect(page.current_path).to eq term_path
      end

      it 'プライバシーポリシー' do
        click_link 'footer_privacy'
        expect(page.current_path).to eq privacy_path
      end

      it 'よくある質問' do
        click_link 'footer_faq'
        expect(page.current_path).to eq faq_path
      end

      it 'お問い合わせ' do
        expect(page).to have_link 'お問い合わせ', href: 'https://forms.gle/Z8WNE7HpJw3NnH8F6'
      end
    end

    context 'ログイン済みの場合' do
      before do
        user.confirm
        sign_in user
        visit root_path
      end

      it '日記を書く' do
        click_link '日記を書く'
        expect(page.current_path).to eq new_post_path
      end

      it 'ユーザー一覧' do
        click_link 'ユーザー一覧'
        expect(page.current_path).to eq users_path
      end

      it 'アカウント設定' do
        click_link 'アカウント設定'
        expect(page.current_path).to eq unsubscribe_path(user)
      end
    end

    context '管理者権限をもつユーザーの場合' do
      before do
        admin.confirm
        sign_in admin
        visit root_path
      end
# # sassc-rails とrails_admin との依存関係によりテスト不可
#       it '管理者ページ' do
#         click_link '管理者ページ'
#         expect(response).to have_http_status(200)
#       end
    end
  end
end
