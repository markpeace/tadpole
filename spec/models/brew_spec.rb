require 'spec_helper'

describe Brew do

	it { should belong_to :user }
	it { should validate_presence_of :user }
	
	it { should validate_presence_of :name }
	
	pending "write a validator to check presence of brew name in brewtoad"
	pending "write a function to retreive a hash of data from brewtoad on the brew"

end
