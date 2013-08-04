require 'spec_helper'

describe Step do

	before :each do 
		User.destroy_all
	end

	it "should be valid when everything is in place" do
		FactoryGirl.build(:step).should be_valid
	end
	
	it { should belong_to(:user) }
	it { should validate_presence_of(:user) }

	it { should belong_to(:brew) }	
	it { should validate_presence_of(:brew) }
	
	it { should validate_presence_of(:days) }
	it { should validate_presence_of(:title) }
	
	pending "it should automatically add an order if one isn't added"
	pending "it should automatically update dates of self and subsequent when added/updated"
	
end
