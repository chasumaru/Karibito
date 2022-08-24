class Users::AccountsController < ApplicationController
  before_action :sign_in_required, only: %i[show unsubscribe following followers]
  # before_action :set_post, only: %i[ show edit update destroy]

  include Pagy::Backend

  def show
    @user = User.find(params[:id])
    @pagy_post, @posts = pagy(@user.posts, items: 18)
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

  def favorite
    @post = Post.find_by(params[:id])
    if @post.liked_users.present?
      @liked_users = @post.liked_users
    end
  end
end

