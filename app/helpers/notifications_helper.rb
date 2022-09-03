module NotificationsHelper

  def notification_form(notification)
	  @visitor = notification.visitor
	  @comment = nil
	  @visitor_comment = notification.comment_id
	  #notification.actionがfollowかlikeかcommentか
	  case notification.action
	    when "follow" then
	      tag.span(tag.a(notification.visitor.name, href:profile_path(@visitor), class: "text-xs font-semibold hover:underline")+tag.p("があなたをフォローしました", class:"text-xs"), class: "flex flex-wrap")
	    when "like" then
	      tag.span(tag.a(notification.visitor.name, href:profile_path(@visitor), class: "text-xs font-semibold hover:underline")+tag.a('があなたの投稿', href:post_path(notification.post_id), class: "text-xs")+tag.span("にいいねしました", class:"text-xs"), class: "flex flex-wrap")
	    when "comment" then
	    	@comment = Comment.find_by(id: @visitor_comment)&.context
	    	tag.span(tag.a(@visitor.name, href:profile_path(@visitor), class: "text-xs font-semibold hover:underline")+tag.a('があなたの投稿', href:post_path(notification.post_id), class: "text-xs")+tag.span("にコメントしました", class:"text-xs"), class: "flex flex-wrap")
	  end
	end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
