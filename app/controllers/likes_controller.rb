class LikesController < ApplicationController
  before_action :sign_in_required, {only: [:create, :destroy]}

  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    @post = Post.find(params[:post_id])
    @post.create_notification_by(current_user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
    redirect_to request.referer, status: :see_other 
  end
  
  private
    def like_params
      params.require(:like).permit(:post_id, :user_id)
    end
end