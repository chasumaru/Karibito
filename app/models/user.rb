class User < ApplicationRecord


  # Valdation
  validates :name, presence: true, length: { maximum: 30 }
  validates :profile, length: { maximum: 200 }
  validates :avatar, presence: true, unless: :avatar_not_attached?
  validates :background, presence: true, unless: :background_not_attached?
  validate :avatar_size, unless: :avatar_not_attached?
  validate :background_size, unless: :background_not_attached?
  
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

  # Assortiation
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :boards
  has_many :board_comments


  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_one_attached :avatar
  has_one_attached :background
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  acts_as_taggable_on :positions

  def send_devise_notification(notification, *args)
    # deliver_laterを使って非同期送信するように修正
    devise_mailer.send(notification, self, *args).deliver_later
  end

  # いいね関連
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  # フォロー関連
  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end


  def following?(other_user)
    following.include?(other_user)
  end

  # # 現状、不要
  # def resized_avatar
  #   return self.avatar.variant(
  #     resize_to_fill: [800, 800], sampling_factor: "4:2:0", strip: true, interlace: "JPEG", colorspace: "sRGB", quality: 85).processed
  # end

  private

  def avatar_not_attached?
   !( self.avatar.attached?)
  end

  def background_not_attached?
   !( self.background.attached?)
  end

  # 10MB以上のファイルを許可しない
  def avatar_size
    if avatar.blob.byte_size > 10485760
      errors.add :avatar, 'ファイルサイズが大きすぎます。'
    end
  end

  def background_size
    if background.blob.byte_size > 10485760
      errors.add :background, 'ファイルサイズが大きすぎます。'
    end
  end
end
