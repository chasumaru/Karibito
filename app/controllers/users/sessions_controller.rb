# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # https://qiita.com/cigalecigales/items/16ce0a9a7e79b9c3974e
  def create
    @user = User.new(user_params)
    if user_signed_in?
      flash[:notice] = "ログインしました。"
      redirect_to root_path
      # redirect_to mypage_path(@user)
    else
      flash[:alert] = "メールアドレスまたはパスワードが正しくありません。"
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
  
    # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
    def reject_user
      @user = User.find_by(email: user_params[:email])
      if @user 
        if @user.valid_password?(user_params[:password]) && (@user.is_deleted == false)
          flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
          render :new, status: :unprocessable_entity
        else
          flash[:notice] = "項目を入力してください"
        end
      end
    end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
