require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /" do
    it "returns http success" do
      get "/"

      expect(response).to have_http_status(:success)
    end

    context "with existing and available shops" do
      let!(:shops) { [Shop.create(name: "shop01", available_on: DateTime.now - 1.day), Shop.create(name: "shop02", available_on: DateTime.now - 1.day)] }

      it "returns a list of shop" do
        get "/"

        expect(@controller.instance_variable_get(:@shops)).to eq(shops)
      end
    end

    context "with existing shops and certain not available" do
      let!(:shop_available) { Shop.create(name: "shop01", available_on: DateTime.now - 1.day) }
      let!(:shop_not_abvailable) { Shop.create(name: "shop02", available_on: DateTime.now + 1.day) }

      it "returns only the available shops" do
        get "/"

        expect(@controller.instance_variable_get(:@shops)).to eq([shop_available])
      end
    end
  end

end
