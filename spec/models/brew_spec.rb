require 'spec_helper'

describe Brew do

	before :each do
		User.destroy_all
	end

	it "should be valid when everything is in place" do
		FactoryGirl.build(:brew).should be_valid
	end

	it { should belong_to :user }
	it { should validate_presence_of :user }
	
	it { should validate_presence_of :name }

	describe "it should have a function that scrapes data from brewtoad" do
	
		it "should return parsed data from xml" do
			b=FactoryGirl.create(:brew)
			b.xml.should_not be_nil
		end
	
		it "should raise an error when a non-valid name is given" do
			FactoryGirl.build(:brew, name:"this does not exist").should_not be_valid
		end
	end

end
