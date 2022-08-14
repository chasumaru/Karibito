class CommentsController < ApplicationController
  # コメントにはedit,updateが不要。new はturbo-streamに必要か？

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to request.referer, notice: "コメントを投稿しました"
    else
      flash.now.alert = 'コメントの投稿に失敗しました'
      render template: "posts/show", status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: "コメントを編集しました"
    else
      flash.now.alert = "コメントの編集に失敗しました"
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to request.referer, notice: "コメントを削除しました。", status: :see_other 
  end

  private
  def comment_params
    params.require(:comment).permit(:context, :reply_comment_id).merge(post_id: params[:post_id])
  end
end
