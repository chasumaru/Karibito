class StaticPagesController < ApplicationController
  before_action :sign_in_required, only: [:show]

  def index
    # ユーザ一覧画面を表示
  end

  def show
    # @user = User.find_by...?
    # ユーザのプロフィール画面を表示
  end

  def about; end

  def faq; end
end
