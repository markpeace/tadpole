require 'spec_helper'

describe User do
	it { should have_many(:brews).dependent(:destroy) }
	it { should have_many(:steps).dependent(:destroy) }
	it { should have_many(:inventories).dependent(:destroy) }
end
