class Comment < ApplicationRecord
  validates :context, presence: true, length:  { maximum: 150 }
  belongs_to :user
  belongs_to :post
  belongs_to :comment, foreign_key: :reply_comment_id, optional: true
  has_many :replies, class_name: 'Comment', foreign_key: :reply_comment_id, dependent: :destroy
end
