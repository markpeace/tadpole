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
	
	def self.shoppinglist(todate, user)
	
		list=[]
	
		Brew.where(["brewed=? AND user_id=? AND date<?", false, user, todate]).each do |b|
			[:HOP, :FERMENTABLE, :YEAST].each do | addition_type |
				Brew.first.xml.root.search("//#{addition_type}").each do | addition |
					l=addition.css("NAME").children[0].content
					amount = addition.css("DISPLAY_AMOUNT").children[0].content rescue "1 g"
					amount = process_units(amount)
					found=false
					list.each do |existing|
						if existing[:label]==l then
							found=true
						end
					end
					if found==false
						onhand=user.inventories.where(:label=>l).first.grams rescue 0	
						list << {type: addition_type, label: l, grams: amount, onhand: onhand }
					end
				end
			end
		end

		list
		
	end

end

def process_units(amount)
	a=amount.split(" ")
	case a[1]
		when "g" 
			return a[0].to_i 
		when "kg"
			return (a[0].to_f * 1000).to_i
	end
end