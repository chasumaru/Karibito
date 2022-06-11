class PostsController < ApplicationController
  before_action :sign_in_required, only: [:new, :create]
  
def index
  # @posts = Post.order(created_at: :desc)
  @pagy, @posts = pagy(Post.order(created_at: :desc), items: 10)
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
      flash[:alert] = "記事の作成に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end
  
  def show 
    @post = Post.find(params[:id])
  end


private

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
