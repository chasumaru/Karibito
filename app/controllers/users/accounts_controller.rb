class Users::AccountsController < ApplicationController
  before_action :sign_in_required, only: %i[show unsubscribe following followers]
  # before_action :set_post, only: %i[ show edit update destroy]

  def show
    @user = User.find(params[:id])
    @pagy_post, @posts = pagy( Post.where(user_id: @user.id), page_param: :page_post )
    # @pagy_post = pagy(@user.posts)
  end

  def unsubscribe; end

  def following
    @user = User.find(params[:id])
    @users = @user.following
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end
end

