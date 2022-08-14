class Comment < ApplicationRecord
  validates :context, presence: true
  belongs_to :user
  belongs_to :post
end
