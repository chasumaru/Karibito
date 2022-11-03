class Board < ApplicationRecord
  belongs_to :user, foreign_key: :user_id, optional: true
  has_many :board_comment, dependent: :destroy
  has_one_attached :illustration
  acts_as_taggable
  
  # validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }
  validates :tag_list, length: { maximum: 40 }
  validate :image_size

  def thumbnail
    return self.illustration.variant(resize_to_fill: [128, 128], sampling_factor: "4:2:0", strip: true, interlace: "JPEG", colorspace: "sRGB", quality: 85).processed
  end

  private
  # 10MB以上の画像ファイルを許可しない
  def image_size
    if illustration.present?
      if illustration.blob.byte_size > 10485760
        errors.add :illustration, 'ファイルサイズが大きすぎます。'
      end
    end
  end
end
