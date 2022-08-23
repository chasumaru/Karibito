class Users::AccountsController < ApplicationController
  before_action :sign_in_required, only: %i[show unsubscribe following followers]
  # before_action :set_post, only: %i[ show edit update destroy]

  def show
    @user = User.find(params[:id])
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

