require 'rails_helper'

RSpec.describe "Shops", type: :request do
  describe "GET /show" do
    context "with an existing and available shop" do
      let!(:shop) { Shop.create(name: "shop1", available_on: DateTime.now - 1.day, slug: 'shop1') }
      it "returns http success" do
        get "/shops/shop1"
        expect(response).to have_http_status(:success)
      end

      it "returns the shop corresponding to the slug" do
        get "/shops/shop1"
        expect(@controller.instance_variable_get(:@shop)).to eq(shop)
      end

      context "with taxons existing" do
        let!(:taxons) { [Taxon.create(name: "taxon1"), Taxon.create(name: "taxon2"), Taxon.create(name: "taxon3")] }        
        context "with products in taxons existing" do
          it "returns the taxons whith shop products in" do
            taxon1 = Taxon.first
            
            product1 = Product.create(name: "Product1")
            product1.shop = shop
            product1.taxons = [taxon1]
            product1.save
            
            get "/shops/shop1"
            expect(@controller.instance_variable_get(:@taxons_products)).to eq({taxon1 => [product1]})
          end

          it "returns the taxons whith shop products in without double taxons" do
            taxon1 = Taxon.first
            taxon2 = Taxon.all[1]            
            
            product1 = Product.create(name: "Product1")
            product1.shop = shop
            product1.taxons = [taxon1]
            product1.save

            product2 = Product.create(name: "Product2")
            product2.shop = shop
            product2.taxons = [taxon1]
            product2.save

            product3 = Product.create(name: "Product3")
            product3.shop = shop
            product3.taxons = [taxon2]
            product3.save

            product4 = Product.create(name: "Product4")
            product4.shop = shop
            product4.taxons = [taxon2]
            product4.save           
            
            get "/shops/shop1"
            
            expected_taxons_products = { taxon1 => [product1, product2], taxon2 => [product3, product4] }
            expect(@controller.instance_variable_get(:@taxons_products)).to eq(expected_taxons_products)
          end

          it "returns the taxons whith shop products in without double taxons, products in multi taxons" do
            taxon1 = Taxon.first
            taxon2 = Taxon.all[1]            
            
            product1 = Product.create(name: "Product1")
            product1.shop = shop
            product1.taxons = [taxon1]
            product1.save

            product2 = Product.create(name: "Product2")
            product2.shop = shop
            product2.taxons = [taxon1, taxon2]
            product2.save

            product3 = Product.create(name: "Product3")
            product3.shop = shop
            product3.taxons = [taxon2]
            product3.save

            product4 = Product.create(name: "Product4")
            product4.shop = shop
            product4.taxons = [taxon1, taxon2]
            product4.save           
            
            get "/shops/shop1"
            
            expected_taxons_products = { taxon1 => [product1, product2, product4], taxon2 => [product2, product3, product4] }
            expect(@controller.instance_variable_get(:@taxons_products)).to eq(expected_taxons_products)
          end
        end

        context "without product in taxons existing" do
          it "returns the taxons whith shop products in" do                                 
            get "/shops/shop1"
            expect(@controller.instance_variable_get(:@taxons_products)).to be_empty
          end
        end
      end
    end

    context "with an existing and unavailable shop" do
      let!(:shop) { Shop.create(name: "unavailableshop1", available_on: DateTime.now + 1.day, slug: 'unavailableshop1') }
      it "returns http 404" do        
        expect {get "/shops/unavailableshop1"}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "with an unexisting shop" do      
      it "returns http 404" do        
        expect {get "/shops/noshop"}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

end
