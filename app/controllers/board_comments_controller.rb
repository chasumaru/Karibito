class BoardCommentsController < ApplicationController
  before_action :sign_in_required, only: [:edit, :update, :destroy]
  before_action :set_board, only: [:create, :edit, :update]
  before_action :set_board_comment, only: [:edit, :update, :destroy]
  before_action :ensure_correct_user,{only: [:edit, :update, :destroy]}
 
  def create
    @board_comment = BoardComment.create(board_comment_params)
    if current_user
      @board_comment.user_id = current_user.id
    end
    if @board_comment.save
      flash.now.notice = "コメントを投稿しました。"
    else
      redirect_to request.referer, alert: "コメントの作成に失敗しました。", status: :see_other 
    end
  end

  def edit
  end
  
  def update
    if @board_comment.update(board_comment_params)
      flash.now.notice = "コメントを更新しました。"
    else
      flash.now.alert = "コメントの編集に失敗しました。"
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    @board_comment.destroy
    flash.now.notice = "コメントを削除しました。"
  end

  private

  def board_comment_params
    params.require(:board_comment).permit(:description, :anonymous_flag).merge(board_id: params[:board_id])
  end

  def set_board
    @board = Board.find(params[:board_id])
  end

  def set_board_comment
    @board_comment = BoardComment.find(params[:id])
  end
  
  def ensure_correct_user
    @board_comment = BoardComment.find_by(id: params[:id])
    if @board_comment.user_id.nil?
      redirect_to boards_path, notice: "権限がありません"
    elsif
      @board_comment.user_id != current_user.id
      redirect_to boards_path, notice: "権限がありません"
    end
  end
end