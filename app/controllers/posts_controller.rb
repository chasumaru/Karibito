class PostsController < ApplicationController
  before_action :sign_in_required, only: %i[new create]
  before_action :set_post, only: %i[ show edit update destroy]

  def index
    # @posts = Post.order(created_at: :desc)
    @pagy, @posts = pagy(Post.order(created_at: :desc), items: 10)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      flash[:alert] = 'ツイートの作成に失敗しました。'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    #添付画像を個別に削除
    if params[:post][:image_ids]
      params[:post][:image_ids].each do |image_id|
        image = @post.images.find(image_id)
        image.purge
      end
    end

    if @post.update(post_params)
      redirect_to @post, notice: "ツイート内容が更新されました."
    else
      render :edit, status: :unprocessable_entity 
    end
  end
  
  def destroy
    @post.destroy
    redirect_to posts_url, notice: "ツイートを削除しました。"
    # flash.now.notice = "ツイートを削除しました。"

  end




  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, images: [])
  end
end
