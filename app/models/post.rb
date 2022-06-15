class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 75 }
  validates :content, presence: true, length: { maximum: 255 }
end
