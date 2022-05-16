class User < ApplicationRecord
  
  validates :name, presence: true
  validates :email, presence: true, length: { maximum: 255 }
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
         :validatable,
         :timeoutable
         #  #omniauthableは後で設定
         #  :omniauthable, omniauth_providers: [:twitter]
end
