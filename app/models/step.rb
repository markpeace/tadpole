class Step < ActiveRecord::Base

	belongs_to :user
	validates_presence_of :user
	
	belongs_to :brew
	validates_presence_of :brew
	
	validates_presence_of :title
	validates_presence_of :days
	
	before_create :autocalculate_order
	def autocalculate_order
		self.steporder = Step.where(:brew_id=>self.brew_id).count+1
	end
	
	def move(direction)
		if direction==:up then
			return if self.steporder==1
			Step.where(:brew_id=>self.brew_id, :steporder=>self.steporder-1).first.update_columns(:steporder=>self.steporder)
			self.update_columns(:steporder=>self.steporder-1)
		elsif direction==:down then
			return if self.steporder==Step.where(:brew_id=>self.brew_id).count
			Step.where(:brew_id=>self.brew_id, :steporder=>self.steporder+1).first.update_columns(:steporder=>self.steporder)
			self.update_columns(:steporder=>self.steporder+1)
		end 
		self.autocalculate_dates
	end
	
	
	after_save :autocalculate_dates
	after_destroy :autocalculate_dates
	
	def autocalculate_dates
		d=self.brew.date
		i=0
		o=1
		Step.where(:brew_id=>self.brew_id).order("[steporder] ASC").each do |s|
			s.update_columns(:date=>d + i, :steporder=>o)
			i=s.days.to_i
			d=s.date
			o=o+1
		end
	end
	
	def complete
		return false if Step.where(:brew=>self.brew, :completed=>false).where("[steporder]<?", self.steporder).count>0
		
		start_date = self.date
		end_date = Date.today
		
		day_difference = ( end_date - start_date ).to_i
	
		self.update_attributes(:completed=>true, :days=>day_difference)
	end

end
