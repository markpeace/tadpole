require 'spec_helper'

describe "inventories/index" do
  before(:each) do
    assign(:inventories, [
      stub_model(Inventory,
        :user_id => 1,
        :label => "MyText",
        :grams => 2
      ),
      stub_model(Inventory,
        :user_id => 1,
        :label => "MyText",
        :grams => 2
      )
    ])
  end

  it "renders a list of inventories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
