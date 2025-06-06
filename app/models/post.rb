class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :notifications, dependent: :destroy
  has_many_attached :images
  acts_as_taggable

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, length: { maximum: 400 }
  validates :tag_list, length: { maximum: 40 }
  validate :validate_image_size_limit, :validate_image_count_limit
  
  def thumbnail
    return self.images.first.variant(resize_to_fill: [1200, 900], sampling_factor: '4:2:0', strip: true, interlace: 'JPEG', colorspace: 'sRGB', quality: 85).processed
  end

  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: 'like'
    )
    notification.save if notification.valid?
  end

  def create_comment_notification!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
        save_comment_notification!(current_user, comment_id, temp_id['user_id'])
      end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_comment_notification!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_comment_notification!(current_user, comment_id, visited_id)
      # １つの投稿に複数回通知する
      notification = current_user.active_notifications.new(
        post_id: id,
        comment_id: comment_id,
        visited_id: visited_id,
        action: 'comment'
      )
      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
   end

  private
  # 10MB以上の画像ファイルを許可しない
  def validate_image_size_limit
    images.blobs.each do |image|
      if image.byte_size > 10485760
        errors.add :images, 'ファイルサイズが大きすぎます。'
      end
    end
  end

  def validate_image_count_limit
    if images.blobs.count > 20
      images.purge
      errors.add :images, '画像枚数の上限を超えています。'
    end
  end

  def favorited_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
