require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

    describe 'ユーザー登録' do
     it "name、email、passwordとpassword_confirmationが存在すれば登録できること" do
       expect(user).to be_valid
     end
     
     it'nameがnilの場合' do
      user.name = ''
      expect(user).not_to be_valid
     end

     it 'nameは30文字以内であること' do
      user.name = 'b' * 31
      expect(user).not_to be_valid
    end

     it'emailがnilの場合' do
      user.email = ''
      expect(user).not_to be_valid
     end

     it 'emailが有効な形式であること' do
      valid_addresses = %w[user@exmple.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end

    it 'emailは重複して登録できないこと' do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save
      expect(duplicate_user).not_to be_valid
    end

    it 'emailは小文字でDB登録されていること' do
      mixed_case_email = 'Foo@ExAMPle.CoM'
      user.email = mixed_case_email
      user.save
      expect(user.reload.email).to eq mixed_case_email.downcase
    end

    it 'passwordが必須であること' do
      user.password = user.password_confirmation = ' '
      expect(user).not_to be_valid
    end
   
    it 'passwordは6文字以上であること' do
      user.password = user.password_confirmation = 'a' * 5
      expect(user).not_to be_valid
    end
  end
end