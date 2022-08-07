class PostsController < ApplicationController
  before_action :sign_in_required, except: [:index, :show]
  before_action :set_post, only: %i[ show edit update destroy]
  before_action :ensure_correct_user,{only: [:edit,:update,:destroy]}

  # require "image_processing/mini_magick"
  require "mini_magick"

  def index
    # @posts = Post.order(created_at: :desc)
    @pagy, @posts = pagy(Post.order(created_at: :desc), items: 30)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to posts_path, notice: "新しい日記を作成しました."
    else
      flash.now.alert = '日記の作成に失敗しました。'
      render :new, status: :unprocessable_entity
    end
  end

  # def create
  #   @post = Post.new(post_params)
  #   @post.user = current_user
  #   if @post.save
  #     @last_post = Post.where(user_id: current_user.id).last
  #     if @last_post.images.attached?
  #       img_records = @last_post.images
  #       img_records.each do |image|
  #         img_data = image.download
  #         image = MiniMagick::Image
  #         .read(img_data)
  #         image.sampling_factor "4:2:0"
  #         image.strip
  #         image.resize "300x200"
  #         image.quality "85"
  #         # {image.write [パス]}で上書きしたいが、ActiveStorageからblobのURLを取得する方法が不明。
  #       end
  #     end
  #     redirect_to posts_path, notice: "新しい日記を作成しました."
  #   else
  #     flash.now.alert = '日記の作成に失敗しました。'
  #     render :new, status: :unprocessable_entity
  #   end
  # end

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
      redirect_to @post, notice: "日記の内容が更新されました."
    else
      render :edit, status: :unprocessable_entity 
    end
  end
  
  def destroy
    @post.destroy
    redirect_to posts_path, notice: "日記を削除しました。", status: :see_other 
    # flash.now.notice = "日記を削除しました。"

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
