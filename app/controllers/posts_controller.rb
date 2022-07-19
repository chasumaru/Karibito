class PostsController < ApplicationController
  before_action :sign_in_required, except: [:index, :show]
  before_action :set_post, only: %i[ show edit update destroy]
  before_action :ensure_correct_user,{only: [:edit,:update,:destroy]}

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
  end

  def update
    #チェックした削除がある場合にのみ個別削除
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
    redirect_to posts_path, notice: "ツイートを削除しました。", status: :see_other 
    # flash.now.notice = "ツイートを削除しました。"

  end




  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, images: [])
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != current_user.id
    redirect_to posts_path, notice: "権限がありません"
    end
  end
end
