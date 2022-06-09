class PostsController < ApplicationController
  
  
def index
  @posts = Post.order(created_at: :desc)
# 投稿順(最新順)にデータを表示させるようにする
end
  
  def new
    @post = Post.new
  end

  def create
    @post=Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      flash[:alert] = "記事の作成に失敗しました。。"
      render :new, status: :unprocessable_entity
    end
  end


private

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
