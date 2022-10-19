class StaticPagesController < ApplicationController

  def index
    # 直近2週間でいいねの多い投稿をランキングで表示する
    to_p           = Time.current.at_end_of_day
    from_p         = (to_p - 30.day).at_beginning_of_day
    @popular_posts = (Post.includes(:images_attachments, :user, :tags).with_attached_images.sort_by {|x|
      x.liked_users.includes(:likes).where(created_at: from_p...to_p).size
    }.reverse).first(20)

    # 直近2週間でいいねを積極的に行うユーザーをランキングで表示する
    to_u           = Time.current.at_end_of_day
    from_u         = (to_u - 14.day).at_beginning_of_day
    @popular_users = (User.includes(:background_attachment, :avatar_attachment, :background_attachment, :positions, :position_taggings).with_attached_avatar.with_attached_background.sort_by {|x|
      x.liked_posts.includes(:likes).where(created_at: from_u...to_u).size
    }.reverse).first(20)
    
    # 直近2週間で積極的にコメントされた掲示板をランキングで表示する
    to_b            = Time.current.at_end_of_day
    from_b          = (to_b - 14.day).at_beginning_of_day
    @popular_boards = (Board.includes(:tags).sort_by{|x|
      x.board_comment.where(created_at: from_b...to_b).size
    }.reverse).first(30)
  end

  def about; end
  def privacy; end
  def faq; end
end

