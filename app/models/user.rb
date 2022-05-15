class User < ApplicationRecord
  validates(:name, presence: true)
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :confirmable,
         :lockable,
         :timeoutable
  # 論理削除の設定
  # :validatable,
  #  #omniauthableは後で設定
  #  :omniauthable, omniauth_providers: [:twitter]

  #kakurenbo-putiの有効化
  soft_deletable
  #論理削除対応のvalidation(email)
  validates :email, presence: true, length: { maximum: 255 }
  validates_uniqueness_of :email, scope: :soft_destroyed_at
  validates_format_of :email, with: Devise.email_regexp, if: :will_save_change_to_email?
  validates :password, presence: true, confirmation: true, length: { in: Devise.password_length }, on: :create
  validates :password, confirmation: true, length: { in: Devise.password_length }, allow_blank: true, on: :update
    
end
