class BoardComment < ApplicationRecord
  belongs_to :user
  belongs_to :board
  belongs_to :board_comment, foreign_key: :reply_comment_id, optional: true
  has_many :replies, class_name: 'BoardComment', foreign_key: :reply_comment_id, dependent: :destroy

end
