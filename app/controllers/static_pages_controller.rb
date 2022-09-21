class StaticPagesController < ApplicationController

  def index
    @posts = Post.all
    @users = User.all
  end

  def about; end
  def privacy; end
  def faq; end

end

