require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  it "displays the title shops list" do
    assign(:shops, [Shop.create(name: "shop1"), Shop.create(name: "shop2")])
    
    render

    expect(rendered).to match /Liste des commerçants/
  end

  it "displays all shops" do
    assign(:shops, [Shop.create(name: "shop1"), Shop.create(name: "shop2")])

    render

    expect(rendered).to match /shop1/
    expect(rendered).to match /shop2/
  end

  it "displays all shops variation" do
    assign(:shops, [Shop.create(name: "shop3"), Shop.create(name: "shop4")])

    render

    expect(rendered).to match /shop3/
    expect(rendered).to match /shop4/
  end

  it "displays a message if no shops exist" do
    assign(:shops, [])

    render

    expect(rendered).to match /Pas encore de commerçants sur la plateforme, ils arrivent prochainement ;\)/
  end
end
