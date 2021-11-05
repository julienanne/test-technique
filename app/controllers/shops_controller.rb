class ShopsController < ApplicationController
  def show
    @shop = Shop.available.find_by_slug!(params[:slug])
    @products = @shop.products.includes(:taxons)
    @taxons_products = {}
    @products.each do |product|
      product.taxons.each do |taxon|
        if !@taxons_products.has_key?(taxon)        
          @taxons_products[taxon] = []
        end
        @taxons_products[taxon] << product
      end
    end
  end
end
