require 'spec_helper'

describe "inventories/show" do
  before(:each) do
    @inventory = assign(:inventory, stub_model(Inventory,
      :user_id => 1,
      :label => "MyText",
      :grams => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/MyText/)
    rendered.should match(/2/)
  end
end
