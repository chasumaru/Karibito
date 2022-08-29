class Board < ApplicationRecord
  belongs_to :user
  has_many :board_comment, dependent: :destroy

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 400 }
  # validate :image_size,

  private
  # 10MB以上の画像ファイルを許可しない
  def image_size
    images.blobs.each do |image|
      if image.byte_size > 10485760
        errors.add :images, 'ファイルサイズが大きすぎます。'
      end
    end
  end
end
