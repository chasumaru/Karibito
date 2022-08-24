class Users::AccountsController < ApplicationController
  before_action :sign_in_required, only: %i[show unsubscribe following followers]
  # before_action :set_post, only: %i[ show edit update destroy]

  include Pagy::Backend

  def show
    @user = User.find(params[:id])
    @pagy_post, @posts = pagy(@user.posts)
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

  def liked_users
    @post = Post.find_by(params[:id])
    @users = @post.liked
  end
end

