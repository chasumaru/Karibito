class BoardCommentsController < ApplicationController
 
  def create
    @board = Post.find(params[:board_id])
    @comment = current_user.comments.new(board_comment_params)
    if @comment.save
      redirect_to request.referer, notice: "コメントを投稿しました。"
    else
      redirect_to request.referer, alert: "コメントの作成に失敗しました。", status: :see_other 
    end
  end

  def edit
    @board = Post.find(params[:board_id])
    @comment = BoardComment.find(params[:id])
  end
  
  def update
    @board = Post.find(params[:board_id])
    @comment = BoardComment.find(params[:id])
    if @comment.update(board_comment_params)
      redirect_to post_path(@board), notice: "コメントを編集しました。"
    else
      flash.now.alert = "コメントの編集に失敗しました。"
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    @comment = BoardComment.find(params[:id])
    @comment.destroy
    redirect_to request.referer, notice: "コメントを削除しました。", status: :see_other 
  end

  private
  def board_comment_params
    params.require(:board_comment).permit(:context, :reply_comment_id).merge(board_id: params[:board_id])
  end
end