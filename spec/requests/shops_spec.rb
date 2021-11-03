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
