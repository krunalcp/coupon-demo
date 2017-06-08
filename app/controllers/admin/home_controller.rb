class Admin::HomeController < Admin::AdminController
  before_filter :authenticate_admin!

  def index
  end

end
