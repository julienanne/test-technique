require 'rails_helper'

RSpec.describe "shops/show.html.erb", type: :view do
  it "displays the name of the shop" do
    assign(:shop, Shop.create(name: "shop1"))

    expected_taxons_products = { Taxon.new(name: "Taxon1") => [Product.new(name: "Product1"), Product.new(name: "Product2")], Taxon.new(name: "Taxon2") => [Product.new(name: "Product3"), Product.new(name: "Product4")] }
    assign(:taxons_products, expected_taxons_products)
    
    render

    expect(rendered).to match /shop1/
  end

  it "displays the taxons_products part of the shop" do
    assign(:shop, Shop.create(name: "shop1"))     
    
    expected_taxons_products = { Taxon.new(name: "Taxon1") => [Product.new(name: "Product1"), Product.new(name: "Product2")], Taxon.new(name: "Taxon2") => [Product.new(name: "Product3"), Product.new(name: "Product4")] }
    assign(:taxons_products, expected_taxons_products)
    
    render

    expect(rendered).to match /Taxon1/
    expect(rendered).to match /Taxon2/

    expect(rendered).to match /Product1/
    expect(rendered).to match /Product2/
    expect(rendered).to match /Product3/
    expect(rendered).to match /Product4/
  end

  it "displays a message if no products in the shop" do
    assign(:shop, Shop.create(name: "shop1"))
    assign(:taxons_products, {})
    
    render

    expect(rendered).to match /Aucun produit pour le moment./
  end
end
