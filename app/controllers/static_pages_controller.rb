class StaticPagesController < ApplicationController
  before_action :sign_in_required, only: [:show]

  def index

  end

  def show
  end

  def about; end

  def faq; end

  def manual; end

end

