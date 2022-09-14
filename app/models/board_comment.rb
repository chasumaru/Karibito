class BoardComment < ApplicationRecord
  validates :description, presence: true, length: { maximum: 300 }
  belongs_to :user, foreign_key: :user_id, optional: true
  belongs_to :board
end
