class StaticPagesController < ApplicationController

  def index
    @posts = Post.order(updated_at: :desc).limit(30)
    @users = User.order(updated_at: :desc).limit(30)
    @boards = Board.order(updated_at: :desc).limit(30)
  end

  def about; end
  def privacy; end
  def faq; end

end

