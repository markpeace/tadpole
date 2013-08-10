class Inventory < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :user
	
	validates_presence_of :label
	validates_presence_of :grams
end
