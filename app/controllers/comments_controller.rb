class CommentsController < ApplicationController
  before_action :sign_in_required
  before_action :set_post, only: [:create, :edit, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :ensure_correct_user,{only: [:edit, :update, :destroy]}

  def create
    @comment = current_user.comments.create(comment_params)
    if @comment.save
      @post.create_comment_notification!(current_user, @comment.id)
      flash.now.notice = "コメントを投稿しました。"
    else
      redirect_to request.referer, alert: "コメントの作成に失敗しました。", status: :see_other
    end
  end

  def edit
  end
  
  def update
    if @comment.update(comment_params)
      flash.now.notice = "コメントを更新しました。"
    else
      flash.now.alert = "コメントの更新に失敗しました。"
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    @comment.destroy
    flash.now.notice = "コメントを削除しました。"
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

  def ensure_correct_user
    @comment = Comment.find_by(id: params[:id])
    if @comment.user_id.nil?
      redirect_to comments_path, notice: "権限がありません"
    elsif
      @comment.user_id != current_user.id
      redirect_to comments_path, notice: "権限がありません"
    end
  end
end
