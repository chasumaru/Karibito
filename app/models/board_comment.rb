class BoardComment < ApplicationRecord
  belongs_to :user, foreign_key: :user_id, optional: true
  belongs_to :board
end
