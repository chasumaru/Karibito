class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  include Pagy::Backend

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, alert: "管理者権限がないのでアクセスできません" }
    end
  end

  unless Rails.env.development?
    # rescue_from Exception,                      with: :_render_500
    rescue_from ActiveRecord::RecordNotFound,   with: :_render_404
    rescue_from ActionController::RoutingError, with: :_render_404
  end

  def render_404
    render partial: 'errors/error_404', status: 404, content_type: 'text/html'
  end
  
  # def render_500
  #   render partial: 'errors/error_500', status: 500, content_type: 'text/html'
  # end

  
  private
  
  def sign_in_required
    redirect_to new_user_session_url unless user_signed_in?
  end

  protected


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name profile avatar background position_list])
  end
end
