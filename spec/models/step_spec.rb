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
	
	it "should automatically add an steporder if one isn't added" do
		u=FactoryGirl.create(:step, steporder:nil)
		u.steporder.should eq(1)
		u=FactoryGirl.create(:step, user:u.user, brew:u.brew, steporder:nil)	
		u.steporder.should eq(2)
	end
	
	describe "it should have re-ordering functions" do 

		before :each do
			u1=FactoryGirl.create(:step, steporder:nil, days: 1)
			u2=FactoryGirl.create(:step, user: u1.user, brew: u1.brew, steporder:nil, days: 1)	
			u3=FactoryGirl.create(:step, user: u1.user, brew: u1.brew, steporder:nil, days: 1)
		end
		
		it "should be ordered correctly to begin with" do
			Step.limit(1).last.steporder.should eq(1)
			Step.limit(2).last.steporder.should eq(2)
			Step.limit(3).last.steporder.should eq(3)
		end
		
		it "should move up when asked" do
			Step.limit(2).last.move(:up)
			Step.limit(1).last.steporder.should eq(2)
			Step.limit(2).last.steporder.should eq(1)
			Step.limit(3).last.steporder.should eq(3)			
		end

		it "shouldn't move up if it's the first" do
			Step.limit(1).last.move(:up)
			Step.limit(1).last.steporder.should eq(1)
			Step.limit(2).last.steporder.should eq(2)
			Step.limit(3).last.steporder.should eq(3)			
		end

		it "should move down when asked" do
			Step.limit(2).last.move(:down)
			Step.limit(1).last.steporder.should eq(1)
			Step.limit(2).last.steporder.should eq(3)
			Step.limit(3).last.steporder.should eq(2)			
		end

		it "shouldn't move down if it's the last" do
			Step.limit(3).last.move(:down)
			Step.limit(1).last.steporder.should eq(1)
			Step.limit(2).last.steporder.should eq(2)
			Step.limit(3).last.steporder.should eq(3)			
		end

		
	end
	
	describe "should automatically update dates" do
		before :each do
			u1=FactoryGirl.create(:step, steporder:nil, days: 5)
			u2=FactoryGirl.create(:step, user: u1.user, brew: u1.brew, steporder:nil, days: 5)	
			u3=FactoryGirl.create(:step, user: u1.user, brew: u1.brew, steporder:nil, days: 5)	
		end
		
		it "should add dates to begin with" do
			Step.limit(1).last.date.strftime('%Y-%d-%m').should eq('2014-01-01')
			Step.limit(2).last.date.strftime('%Y-%d-%m').should eq('2014-06-01')
			Step.limit(3).last.date.strftime('%Y-%d-%m').should eq('2014-11-01')		
		end
		
		it "should update dates when an item is moved" do
			Step.limit(2).last.move(:up)
			Step.limit(2).last.date.strftime('%Y-%d-%m').should eq('2014-01-01')
			Step.limit(1).last.date.strftime('%Y-%d-%m').should eq('2014-06-01')
			Step.limit(3).last.date.strftime('%Y-%d-%m').should eq('2014-11-01')		
		end
	end
	
	describe "should have a complete function" do
	
		before :each do
			u1=FactoryGirl.create(:step, steporder:nil, days: 5)
			u2=FactoryGirl.create(:step, user: u1.user, brew: u1.brew, steporder:nil, days: 5)	
			u3=FactoryGirl.create(:step, user: u1.user, brew: u1.brew, steporder:nil, days: 5)	
		end
		
		it "should complete when complete is called" do
			Step.first.complete
			Step.first.completed.should be_true
			Step.limit(2).last.complete
			Step.limit(2).last.completed.should be_true
			Step.limit(3).last.complete
			Step.limit(3).last.completed.should be_true
		end
		
		it "should not complete if prior steps are incomplete" do
			Step.limit(2).last.complete
			Step.limit(2).last.completed.should be_false
		end
		
		it "should change days if completed early or late" do
			Step.first.complete
			Step.limit(2).last.complete
			Step.limit(2).last.days.should eq(0)
		end
	end
	
end
