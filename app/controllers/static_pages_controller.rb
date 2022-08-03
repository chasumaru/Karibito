class StaticPagesController < ApplicationController
  before_action :sign_in_required, only: [:show]

  def index
    @user = current_user
  end

  def show
    # @user = User.find_by...?
    # ユーザのプロフィール画面を表示
  end

  def about; end

  def faq; end

  def manual; end
end
