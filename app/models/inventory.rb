class Inventory < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :user
	
	validates_presence_of :label
	validates_presence_of :grams
	
	after_save :combine_if_duplicate
	def combine_if_duplicate
		
		if e=Inventory.where("label=? AND id!=? AND user_id!=?", self.label, self.id, self.user_id).first then
			e.update_columns(:grams=>e.grams+self.grams)
			self.destroy 
		end
		
	end
	
	after_save :remove_if_zero_grams
	def remove_if_zero_grams
		self.destroy if self.grams<1 or self.grams.nil?
	end
	
end
