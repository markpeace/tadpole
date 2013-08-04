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
	
	it "should automatically add an order if one isn't added" do
		u=FactoryGirl.create(:step, order:nil)
		u.order.should eq(1)
		u=FactoryGirl.create(:step, user:u.user, brew:u.brew, order:nil)	
		u.order.should eq(2)
	end
	
	it "should have re-ordering functions" do 
		u1=FactoryGirl.create(:step, order:nil, days: 1)
		u2=FactoryGirl.create(:step, user: u1.user, brew: u1.brew, order:nil, days: 1)	
		u3=FactoryGirl.create(:step, user: u1.user, brew: u1.brew, order:nil, days: 1)
		
		u2.move(:up)
		u2.order.should eq(1)
		u1.order.should eq(2)
		u3.order.should eq(3)
		
		u2.move(:up)
		u2.order.should eq(1)
		u1.order.should eq(2)
		u3.order.should eq(3)		
		
		u2.move(:down)
		u1.order.should eq(1)
		u2.order.should eq(2)
		u3.order.should eq(3)

		u3.move(:down)
		u1.order.should eq(1)
		u2.order.should eq(2)
		u3.order.should eq(3)


	end
	
	it "should automatically update dates of self and subsequent when added/updated" do
		u1=FactoryGirl.create(:step, order:nil, days: 1)
		u2=FactoryGirl.create(:step, user: u1.user, brew: u1.brew, order:nil, days: 1)	
		u3=FactoryGirl.create(:step, user: u1.user, brew: u1.brew, order:nil, days: 1)	
		u1.date.strftime('%Y-%d-%m').should eq('2014-01-02')
		u2.date.strftime('%Y-%d-%m').should eq('2014-01-03')
		u3.date.strftime('%Y-%d-%m').should eq('2014-01-04')		
	end
	
end
