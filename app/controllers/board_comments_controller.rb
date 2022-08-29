class BoardCommentsController < ApplicationController
 
  def create
    @board = Board.find(params[:board_id])
    @board_comment = current_user.board_comments.new(board_comment_params)
    if @board_comment.save
      redirect_to request.referer, notice: "コメントを投稿しました。"
    else
      redirect_to request.referer, alert: "コメントの作成に失敗しました。", status: :see_other 
    end
  end

  def edit
    @board = Board.find(params[:board_id])
    @boards = BoardComment.find(params[:id])
  end
  
  def update
    @board = Board.find(params[:board_id])
    @boards = BoardComment.find(params[:id])
    if @board_comment.update(board_comment_params)
      redirect_to post_path(@board), notice: "コメントを編集しました。"
    else
      flash.now.alert = "コメントの編集に失敗しました。"
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    @board_comment = BoardComment.find(params[:id])
    
    @board_comment.destroy
    redirect_to request.referer, notice: "コメントを削除しました。", status: :see_other 
  end

  private
  def board_comment_params
    params.require(:board_comment).permit(:description, :reply_board_comment_id).merge(board_id: params[:board_id])
  end
end