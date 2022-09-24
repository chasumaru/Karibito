class PostsController < ApplicationController
  before_action :sign_in_required, except: [:index, :show, :tags]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user,{only: [:edit, :update, :destroy]}


  require 'mini_magick'
  require 'image_processing/mini_magick'


  def index
    @q = params[:q]
    @q = @q.to_unsafe_hash.transform_values { |v| v.split(/[ |　]/) } if params[:q]
    if params[:tag_name]
      @search = Post.tagged_with("#{params[:tag_name]}").ransack(@q)
    else
      @search = Post.ransack(@q)
    end 
    @search.sorts = 'id desc' if @search.sorts.empty?
    @pagy, @posts = pagy @search.result
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post, notice: '新しい日記を作成しました。'
    else
      flash.now.alert = '日記の作成に失敗しました。'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment  = Comment.new
    @comments = @post.comments.includes(:user)
    @like     = Like.new
    if @post.liked_users.present?
      @liked_users = @post.liked_users.includes(:likes)
    end
  end

  def edit
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
      redirect_to @post, notice: '日記の内容が更新されました。'
    else
      flash.now.alert = '日記の作成に失敗しました。'
      render :edit, status: :unprocessable_entity 
    end
  end
  
  def destroy
    @post.destroy
    redirect_to posts_path, notice: '日記を削除しました。', status: :see_other 
  end


  def liked
    @post = Post.find(params[:id])
    if @post.liked_users.present?
      @liked_users = @post.liked_users.includes(:likes)
    end
  end

  def tags
    @tags = Post.tag_counts_on(:tags).order('name')
  end


  private

  def set_post
    @post = Post.find(params[:id])
  end
  

  def post_params
    params.require(:post).permit(:title, :content, :tag_list, images: [])
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != current_user.id
    redirect_to posts_path, notice: '権限がありません'
    end
  end
end
