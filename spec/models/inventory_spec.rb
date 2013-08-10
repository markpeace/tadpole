require 'spec_helper'

describe Inventory do

	it "should create when valid" do
		FactoryGirl.build(:inventory).should be_valid
	end
	
	it { should belong_to :user }
	it { should validate_presence_of :user }

	it { should validate_presence_of :label }
	it { should validate_presence_of :grams }


end
