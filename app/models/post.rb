class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 75 }
  validates :content, presence: true, length: { maximum: 255 }
  validate :image_size, :image_count
  
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
end
