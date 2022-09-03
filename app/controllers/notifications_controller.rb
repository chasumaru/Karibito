class NotificationsController < ApplicationController
  before_action :sign_in_required, only: %I[index destroy_all]

	def index
		@notifications = current_user.passive_notifications
		@notifications.where(checked: false).each do |notification|
			notification.update(checked: true)
		end
	end

	def destroy_all
		@notifications = current_user.passive_notifications.destroy_all
		redirect_to notifications_path
	end
end