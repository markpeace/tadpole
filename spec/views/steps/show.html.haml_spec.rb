require 'spec_helper'

describe "steps/show" do
  before(:each) do
    @step = assign(:step, stub_model(Step,
      :user_id => 1,
      :brew_id => 2,
      :title => "Title",
      :days => 3,
      :order => 4,
      :completed => false,
      :update_inventory => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Title/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/false/)
    rendered.should match(/false/)
  end
end
