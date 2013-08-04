class Step < ActiveRecord::Base

	belongs_to :user
	validates_presence_of :user
	
	belongs_to :brew
	validates_presence_of :brew
	
	validates_presence_of :title
	validates_presence_of :days

end
