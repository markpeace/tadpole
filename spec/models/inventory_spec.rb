require 'spec_helper'

describe Inventory do
	
	before :each do
		User.destroy_all
	end

	it "should create when valid" do
		FactoryGirl.build(:inventory).should be_valid
	end
	
	it { should belong_to :user }
	it { should validate_presence_of :user }

	it { should validate_presence_of :label }
	it { should validate_presence_of :grams }

	it "remove an entry when its grams are set below 1" do
		FactoryGirl.create(:inventory)
		Inventory.first.update_attributes(:grams=>-10)
		Inventory.count.to_i.should eq(0)
	end
	
	it "if an entry is created which already exists, it should add grams instead" do
		FactoryGirl.create(:inventory, label: 'maris otter', grams: 10)
		FactoryGirl.create(:inventory, label: 'maris otter', grams: 10)
		Inventory.count.should eq(1)
		Inventory.first.grams.should eq(20)
	end

end
