class Step < ActiveRecord::Base

	belongs_to :user
	validates_presence_of :user
	
	belongs_to :brew
	validates_presence_of :brew
	
	validates_presence_of :title
	validates_presence_of :days
	
	before_create :autocalculate_order
	def autocalculate_order
		self.order = Step.where(:brew_id=>self.brew_id).count+1
	end
	
	def move(direction)
		if direction==:up then
			return if self.order==1
			Step.where(:brew_id=>self.brew_id, :order=>self.order-1).first.update_attributes(:order=>self.order)
			self.update_attributes(:order=>self.order-1)
			self.autocalculate_dates
		elsif direction==:down then
			return if self.order==Step.where(:brew_id=>self.brew_id).count
			Step.where(:brew_id=>self.brew_id, :order=>self.order+1).first.update_attributes(:order=>self.order)
			self.update_attributes(:order=>self.order+1)
			self.autocalculate_dates
		end 
		self.save
	end
	
	
	def autocalculate_dates
	end

end
