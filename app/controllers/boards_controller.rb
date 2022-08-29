class BoardsController < ApplicationController
  before_action :sign_in_required, except: [:index, :show, :new, :create]
  before_action :ensure_correct_user,{only: [:edit, :update, :destroy]}

  def index
    @boards  = Board.all
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user = current_user
    if @board.save
      redirect_to @board, notice: "新しいスレッドを作成しました。"
    else
      flash.now.alert = 'スレッドの作成に失敗しました。'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @board = Board.find(params[:id])
  end

  def edit
  end

  def update
    if @post.update(board_params)
      redirect_to @board, notice: "スレッドの内容が更新されました。"
    else
      flash.now.alert = 'スレッドの作成に失敗しました。'
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_path, notice: "スレッドを削除しました。", status: :see_other 
  end
  

  private


  def board_params
    params.require(:board).permit(:title, :description, :anonymous_flag)
  end

  def ensure_correct_user
    @board = Board.find_by(id: params[:id])
    if @border.user_id.nil?
      redirect_to boards_path, notice: "権限がありません"
    elsif
      @board.user_id != current_user.id
      redirect_to boards_path, notice: "権限がありません"
    end
  end
end
