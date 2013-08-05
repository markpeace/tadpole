class CalendarController < ApplicationController

	skip_before_filter :authenticate_user!
	
	include Icalendar
	
	def index
		@steps=Step.where(:user_id=>params[:id]).order("date DESC")
		respond_to do |format|
			format.html { render :index }
			format.ics do
				cal = Calendar.new
				
				@steps.each do |s|
					cal.event do 
						dtstart	s.date
						dtend s.date
						summary "#{s.brew.name}: #{s.title} (#{s.days} days)"
					end
				end
				
				cal.publish
				headers['Content-Type'] = "text/calendar; charset=UTF-8"
				render :text => cal.to_ical, :layout=>false
			end
		end
	end
	
end
