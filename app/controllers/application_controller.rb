class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  include Pagy::Backend

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, alert: "管理者権限がないのでアクセスできません" }
    end
  end

  # unless Rails.env.development?
  #   rescue_from Exception,                      with: :_render_500
  #   rescue_from ActiveRecord::RecordNotFound,   with: :_render_404
  #   rescue_from ActionController::RoutingError, with: :_render_404
  # end
  
  # def routing_error
  #   raise ActionController::RoutingError, params[:path]
  # end

  # def after_sign_in_path_for(resource)
  #   redirect_back(fallback_location: root_path)
  # end
  
  private
  
  # def _render_404(e = nil)
  #   logger.info "Rendering 404 with excaption: #{e.message}" if e
  #   if request.format.to_sym == :json
  #     render json: { error: "404 Not Found" }, status: :not_found
  #   else
  #     render "errors/404.html", status: :not_found, layout: "error"
  #   end
  # end

  # def _render_500(e = nil)
  #   logger.error "Rendering 500 with excaption: #{e.message}" if e

  #   if request.format.to_sym == :json
  #     render json: { error: "500 Internal Server Error" }, status: :internal_server_error
  #   else
  #     render "errors/500.html", status: :internal_server_error, layout: "error"
  #   end
  # end

  def sign_in_required
    redirect_to new_user_session_url unless user_signed_in?
  end

  protected

  # name属性のstrong parameterを追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name profile avatar background position_list])
  end
end
