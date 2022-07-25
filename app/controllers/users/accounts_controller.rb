class Users::AccountsController < ApplicationController
  before_action :sign_in_required, only: %i[show unsubscribe]

  def show
    @user = current_user
  end

  def unsubscribe; end
end
