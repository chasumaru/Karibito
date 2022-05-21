class User < ApplicationRecord
  
  validates :name, presence: true
  validates :profile, length: {maximum: 200}
      
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
