class User < ApplicationRecord
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

  # Valdation
  validates :name, presence: true
  validates :profile, length: { maximum: 200 }

  # Assortiation
  has_many :posts

  has_one_attached :avatar

  def send_devise_notification(notification, *args)
    # deliver_laterを使って非同期送信するように修正
    devise_mailer.send(notification, self, *args).deliver_later
  end

  # 退会したユーザの再登録・ログインを防ぐ
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
