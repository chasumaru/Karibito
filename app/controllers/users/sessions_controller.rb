# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
    session[:previous_url] = request.referer
  end

  # POST /resource/sign_in
  # https://qiita.com/cigalecigales/items/16ce0a9a7e79b9c3974e
  def create
    @user = User.new(user_params)
    if user_signed_in?
      flash[:notice] = 'ログインしました。'
      redirect_to session[:previous_url] 
    else
      flash[:alert] = 'メールアドレスまたはパスワードが正しくありません。'
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
