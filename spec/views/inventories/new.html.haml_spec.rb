require 'spec_helper'

describe "inventories/new" do
  before(:each) do
    assign(:inventory, stub_model(Inventory,
      :user_id => 1,
      :label => "MyText",
      :grams => 1
    ).as_new_record)
  end

  it "renders new inventory form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => inventories_path, :method => "post" do
      assert_select "input#inventory_user_id", :name => "inventory[user_id]"
      assert_select "textarea#inventory_label", :name => "inventory[label]"
      assert_select "input#inventory_grams", :name => "inventory[grams]"
    end
  end
end
