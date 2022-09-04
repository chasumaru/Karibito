class CommentsController < ApplicationController
  before_action :sign_in_required
  before_action :set_post, only: [:create, :edit, :update]
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :ensure_correct_user,{only: [:edit, :update, :destroy]}

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      @post.create_notification_comment!(current_user, @comment.id)
      redirect_to request.referer, notice: "コメントを投稿しました。"
    else
      redirect_to request.referer, alert: "コメントの作成に失敗しました。", status: :see_other 
    end
  end

  def edit
  end
  
  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: "コメントを編集しました。"
    else
      flash.now.alert = "コメントの編集に失敗しました。"
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    @comment.destroy
    redirect_to request.referer, notice: "コメントを削除しました。", status: :see_other 
  end

  private

  def comment_params
    params.require(:comment).permit(:context, :reply_comment_id).merge(post_id: params[:post_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
  
  def set_comment
    @comment = Comment.find(params[:id])
  end
end
