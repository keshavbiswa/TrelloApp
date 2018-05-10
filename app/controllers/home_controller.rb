class HomeController < ApplicationController

  before_action :authenticate_user!
  
  def index
    @boards = current_user.boards
  end

  def contact
  end

  def about
  end
end
