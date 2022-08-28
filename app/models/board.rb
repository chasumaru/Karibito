class Board < ApplicationRecord
  belongs_to :user
  has_many :board_comment
end
