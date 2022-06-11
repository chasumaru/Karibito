class Users::AccountsController < ApplicationController
  before_action :sign_in_required, only: [:show, :unsubscribe, :withdrawal]
  
  def show
    @user = current_user
  end
  # def show
  #   if user_signed_in?
  #     @user = current_user
  #   else
  #     @user = アクセスしたユーザのデータ
  # end

  def unsubscribe
  end

    # is_deletedカラムをtrueに変更する
  def withdrawal
    @user = current_userことにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

end
