class BoardsController < ApplicationController
  before_action :sign_in_required, except: [:index, :show, :new, :create, :tags]
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user,{only: [:edit, :update, :destroy]}


  def index
    @q = params[:q]
    @q = @q.to_unsafe_hash.transform_values { |v| v.split(/[ |　]/) } if params[:q]
    if params[:tag_name]
      @search = Board.tagged_with("#{params[:tag_name]}").ransack(@q)
    else
      @search = Board.ransack(@q)
    end 
    @search.sorts = 'id desc' if @search.sorts.empty?
    @pagy, @boards = pagy @search.result
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user = current_user
    if @board.save
      redirect_to boards_path, notice: "新しいスレッドを作成しました。"
    else
      flash.now.alert = 'スレッドの作成に失敗しました。'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @board          = Board.find(params[:id])
    @board_comment  = BoardComment.new
    @comments = @board.board_comment.includes(:user)
    @tags = @board.tags
  end

  def edit
  end

  def update
    if @board.update(board_params)
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

  def tags
    @tags = Board.tag_counts_on(:tags).order("name")
  end
  
  private
  
  def board_params
    params.require(:board).permit(:title, :description, :anonymous_flag, :illustration, :tag_list)
  end

  def set_board
    @board = Board.find(params[:id])
  end

  def ensure_correct_user
    @board = Board.find_by(id: params[:id])
    if @board.user_id.nil?
      redirect_to boards_path, notice: "権限がありません"
    elsif
      @board.user_id != current_user.id
      redirect_to boards_path, notice: "権限がありません"
    end
  end
end
