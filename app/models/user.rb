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
  validates :avatar, presence: true, unless: :not_attached?
  validate :image_size, unless: :not_attached?


  # Assortiation
  has_many :posts, dependent: :destroy

  has_one_attached :avatar

  def send_devise_notification(notification, *args)
    # deliver_laterを使って非同期送信するように修正
    devise_mailer.send(notification, self, *args).deliver_later
  end

  private

  def not_attached?
   !( self.avatar.attached?)
  end

  # 10MB以上のファイルを許可しない
  def image_size
    if avatar.blob.byte_size > 10485760
      errors.add :avatar, 'ファイルサイズが大きすぎます。'
    end
  end
end
