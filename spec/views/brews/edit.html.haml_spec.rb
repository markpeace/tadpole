require 'spec_helper'

describe "brews/edit" do
  before(:each) do
    @brew = assign(:brew, stub_model(Brew,
      :user_id => 1,
      :name => "MyString"
    ))
  end

  it "renders the edit brew form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => brews_path(@brew), :method => "post" do
      assert_select "input#brew_user_id", :name => "brew[user_id]"
      assert_select "input#brew_name", :name => "brew[name]"
    end
  end
end
