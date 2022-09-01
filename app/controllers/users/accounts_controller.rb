class Users::AccountsController < ApplicationController
  before_action :sign_in_required, only: %i[show unsubscribe following followers index]
  # before_action :set_post, only: %i[ show edit update destroy]

  def show
    @user = User.find(params[:id])
    @pagy_post, @posts = pagy(@user.posts, items: 18)
    @positions = @user.positions
  end
  
  def index
    @q = params[:q]
    @q = @q.to_unsafe_hash.transform_values { |v| v.split(/[ |　]/) } if params[:q]
    if params[:tag_name]
      @search = User.tagged_with("#{params[:tag_name]}").ransack(@q)
    else
      @search = User.ransack(@q)
    end 
    @search.sorts = 'name' if @search.sorts.empty?
    @pagy, @users = pagy @search.result
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

  def positions
    @positions = User.tag_counts_on(:positions).order("name")
  end
end

