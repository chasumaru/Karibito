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
         :timeoutable,
   :omniauthable, omniauth_providers: [:twitter, :google_oauth2]

  # Assortiation
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :boards
  has_many :board_comments
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_one_attached :avatar
  has_one_attached :background
  has_many :active_relationships, class_name:  'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  'Relationship',
                                  foreign_key: 'followed_id',
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  acts_as_taggable_on :positions
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

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

  def create_notification_follow!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ? ',current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  # def self.from_omniauth(auth)
  #   find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.name = auth.info.name
  #   end
  # end
  
  # def self.new_with_session(params, session)
  #   if session["devise.user_attributes"]
  #     new(session["devise.user_attributes"]) do |user|
  #       user.attributes = params
  #     end
  #   else
  #     super
  #   end
  # end

  # def self.find_for_oauth(auth)
  #   user = User.where(uid: auth.uid, provider: auth.provider).first

  #   unless user
  #     user = User.create(
  #       uid:      auth.uid,
  #       provider: auth.provider,
  #       email:    User.dummy_email(auth),
  #       password: Devise.friendly_token[0, 20]
  #     )
  #   end
  #   user.skip_confirmation! #仮登録メールを介さずに即時登録
  #   user
  # end


  private

  # def self.dummy_email(auth)
  #   "#{auth.uid}-#{auth.provider}@example.com"
  # end

  def avatar_not_attached?
   !( self.avatar.attached?)
  end

  def background_not_attached?
   !( self.background.attached?)
  end

  # 10MB以上のファイルを許可しない
  def validate_avatar_size_limit
    if avatar.blob.byte_size > 10485760
      errors.add :avatar, 'ファイルサイズが大きすぎます。'
    end
  end

  def validate_background_size_limit
    if background.blob.byte_size > 10485760
      errors.add :background, 'ファイルサイズが大きすぎます。'
    end
  end
end
