class HomeController < ApplicationController
  def index
    @shops = Shop.available
  end
end
