require 'spec_helper'

describe "steps/new" do
  before(:each) do
    assign(:step, stub_model(Step,
      :user_id => 1,
      :brew_id => 1,
      :title => "MyString",
      :days => 1,
      :order => 1,
      :completed => false,
      :update_inventory => false
    ).as_new_record)
  end

  it "renders new step form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => steps_path, :method => "post" do
      assert_select "input#step_user_id", :name => "step[user_id]"
      assert_select "input#step_brew_id", :name => "step[brew_id]"
      assert_select "input#step_title", :name => "step[title]"
      assert_select "input#step_days", :name => "step[days]"
      assert_select "input#step_order", :name => "step[order]"
      assert_select "input#step_completed", :name => "step[completed]"
      assert_select "input#step_update_inventory", :name => "step[update_inventory]"
    end
  end
end
