class User < ApplicationRecord
  
  # validation(論理削除)
  validates(:name, presence: true)
  validates :email, presence: true, length: { maximum: 255 }
  validates_uniqueness_of :email, scope: :soft_destroyed_at
  validates_format_of :email, with: Devise.email_regexp, if: :will_save_change_to_email?
  validates :password, presence: true, confirmation: true, length: { in: Devise.password_length }, on: :create
  validates :password, confirmation: true, length: { in: Devise.password_length }, allow_blank: true, on: :update
      
  # Include default devise modules. 
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :confirmable,
         :lockable,
         # 論理削除の設定
         # :validatable,
         :timeoutable
         #  #omniauthableは後で設定
         #  :omniauthable, omniauth_providers: [:twitter]

         # kakurenbo-putiの有効化
         soft_deletable

  # without_soft_destroyedを追加する
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    self.without_soft_destroyed.where(conditions.to_h).first
  end
end
