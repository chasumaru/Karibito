class LikesController < ApplicationController
  before_action :sign_in_required, {only: [:create, :destroy]}
  before_action :set_post, {only: [:create, :destroy]}

  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    @liked_users = @post.liked_users
    @post.create_notification_by(current_user)
    flash.now.notice = "いいねができまsita。" 
    # redirect_to request.referer, status: :see_other 
  end

  # def destroy
  #   @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
  #   @like.destroy
  #   redirect_to request.referer, status: :see_other 
  # end
  
  # def create
  #   @like = current_user.likes.create(post_id: params[:post_id])
  #   if @like.save
  #     @post.create_notification_by(current_user)
  #     flash.now.notice = "いいねしました。" 
  #   end
  # end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
    flash.now.notice = "いいねを取り消しました。"
  end
  
  private
    def like_params
      params.require(:like).permit(:post_id, :user_id)
    end

    def set_post
      @post = Post.find(params[:post_id])
    end
end