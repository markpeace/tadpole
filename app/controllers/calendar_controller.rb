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
					confirmation_link=root_url + "steps/#{s.id}/complete"
					cal.event do 
						dtstart	s.date
						dtend s.date
						summary "#{s.brew.name}: #{s.title} (#{s.days} days)"
						description "Click The Following Link To Mark This Step as Complete: " + confirmation_link
						alarm do
							summary "Tadpole Notification: Tomorrow, #{s.brew.name} should be transferred to #{s.title}"
							trigger "-P8H"
						end
					end					
				end
				
				cal.publish
				headers['Content-Type'] = "text/calendar; charset=UTF-8"
				render :text => cal.to_ical, :layout=>false
			end
		end
	end
	
end
