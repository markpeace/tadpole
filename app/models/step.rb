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

end
