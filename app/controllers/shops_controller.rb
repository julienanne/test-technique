class ShopsController < ApplicationController
  def show
    @shop = Shop.available.find_by_slug!(params[:slug])
  end
end
