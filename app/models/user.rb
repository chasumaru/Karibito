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
         #  :omniauthable, omniauth_providers: [:twitter]

  def send_devise_notification(notification, *args)
    # deliver_laterを使って非同期送信するように修正
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
