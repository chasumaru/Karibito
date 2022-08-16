class Users::AccountsController < ApplicationController
  before_action :sign_in_required, only: %i[show unsubscribe]

  def show
    @user = User.find(params[:id])
  end

  def unsubscribe; end
end

