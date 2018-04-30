class HomeController < ApplicationController

  before_action :authenticate_user!
  
  def index
  end

  def contact
  end

  def about
  end
end
