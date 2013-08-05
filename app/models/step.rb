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
			Step.where(:brew_id=>self.brew_id, :order=>self.order-1).first.update_columns(:order=>self.order)
			self.update_columns(:order=>self.order-1)
		elsif direction==:down then
			return if self.order==Step.where(:brew_id=>self.brew_id).count
			Step.where(:brew_id=>self.brew_id, :order=>self.order+1).first.update_columns(:order=>self.order)
			self.update_columns(:order=>self.order+1)
		end 
		self.autocalculate_dates
	end
	
	
	after_save :autocalculate_dates
	after_destroy :autocalculate_dates
	
	def autocalculate_dates
		d=self.brew.date
		i=0
		o=1
		Step.where(:brew_id=>self.brew_id).order("[order] ASC").each do |s|
			s.update_columns(:date=>d + i, :order=>o)
			i=s.days.to_i
			d=s.date
			o=o+1
		end
	end
	
	def complete
		return false if Step.where("brew_id=? AND completed==false AND order<?", self.brew_id, self.order).count>0
		self.update_attributes(:completed=>true)
	end

end
