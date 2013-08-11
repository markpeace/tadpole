class Brew < ActiveRecord::Base
	
	has_many :steps, :dependent=>:destroy	
	
	belongs_to :user
	
	validates_presence_of :user
	
	validates_presence_of :name

	validate { errors.add(:base, 'The recipe must appear on BrewToad') unless xml }
	def xml
		require 'open-uri'
		require 'nokogiri'
		
		begin
			doc = Nokogiri::XML(open("http://www.brewtoad.com/recipes/#{self.name.downcase}.xml")) 
		rescue
			return false
		end
		
		return doc
	end
	
	def self.shoppinglist(todate)
		"Hi"
	end
	
end
