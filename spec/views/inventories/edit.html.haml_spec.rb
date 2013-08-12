require 'spec_helper'

describe "inventories/edit" do
  before(:each) do
    @inventory = assign(:inventory, stub_model(Inventory,
      :user_id => 1,
      :label => "MyText",
      :grams => 1
    ))
  end

  it "renders the edit inventory form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => inventories_path(@inventory), :method => "post" do
      assert_select "input#inventory_user_id", :name => "inventory[user_id]"
      assert_select "textarea#inventory_label", :name => "inventory[label]"
      assert_select "input#inventory_grams", :name => "inventory[grams]"
    end
  end
end
