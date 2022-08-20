class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 75 }
  validates :content, length: { maximum: 255 }
  validate :image_size, :image_count
  
  def thumbnail
    return self.images.first.variant(resize_to_fill: [800, 600], sampling_factor: "4:2:0", strip: true, interlace: "JPEG", colorspace: "sRGB", quality: 85).processed
  end

  # def processed_images
  #   self.posts.each do |i|
  #     i.variant(resize_to_fill: [800, 600], sampling_factor: "4:2:0", strip: true, interlace: "JPEG", colorspace: "sRGB", quality: 85).processed
  #   end
  # end

  def image_processing
    
    (self.images.count - 1).times do |i|
    self.images[i+1].variant(resize_to_fill: [800, 600], sampling_factor: "4:2:0", strip: true, interlace: "JPEG", colorspace: "sRGB", quality: 85).processed
    end


    # self.each do |i|
    #   i.variant(resize_to_fill: [800, 600], sampling_factor: "4:2:0", strip: true, interlace: "JPEG", colorspace: "sRGB", quality: 85).processed
    # end
  end







  private
  # 10MB以上の画像ファイルを許可しない
  def image_size
    images.blobs.each do |image|
      if image.byte_size > 10485760
        errors.add :images, 'ファイルサイズが大きすぎます。'
      end
    end
  end

  def image_count
    if images.blobs.count > 10
      images.purge
      errors.add :images, '画像枚数の上限を超えています。'
    end
  end

  def favorited_by?(user)
    Like.where(user_id: user.id).exists?
  end
end
