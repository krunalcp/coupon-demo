class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  before_action :set_peginate

  def set_peginate
    @per_page = params[:per_page].to_i <= 0 ? PER_PAGE : params[:per_page].to_i
    @page     = params[:page].to_i <= 0 ? 1 : params[:page].to_i
  end
end
