class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pagy::Backend


  def after_sign_in_path_for(resource)
    mypage_path(resource)
  end


  private
      def sign_in_required
          redirect_to new_user_session_url unless user_signed_in?
      end

  protected
    # name属性のstrong parameterを追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :avatar])
  end
end