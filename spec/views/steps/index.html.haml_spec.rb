require 'spec_helper'

describe "steps/index" do
  before(:each) do
    assign(:steps, [
      stub_model(Step,
        :user_id => 1,
        :brew_id => 2,
        :title => "Title",
        :days => 3,
        :order => 4,
        :completed => false,
        :update_inventory => false
      ),
      stub_model(Step,
        :user_id => 1,
        :brew_id => 2,
        :title => "Title",
        :days => 3,
        :order => 4,
        :completed => false,
        :update_inventory => false
      )
    ])
  end

  it "renders a list of steps" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
