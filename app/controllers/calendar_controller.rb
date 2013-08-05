class CalendarController < ApplicationController

	skip_before_filter :authenticate_user!
	
	include Icalendar
	
	def index
		respond_to do |format|
			format.html do
				@steps=Step.where(:user_id=>params[:id], :completed=>false).order("date DESC")
				render :index
			end
			format.ics do
				r=root_url
				cal = Calendar.new
			
				current_user.brews.each do |b|
					steps=b.steps.where(:completed=>false).order("date ASC")
					if steps.count>0 then
						cal.event do
							dtstart	b.date
							dtend b.date
							summary "Brew #{b.name}"
						end
		
						steps.each_with_index do |s,i|
							cal.event do
								dtstart	s.date
								dtend s.date
								summary "#{b.name} to #{s.title} for #{s.days} days"
								description "Click this link to mark step as complete: #{r}steps/#{s.id}/complete" if i==0
								description "You cannot complete this step as prior ones are still incomplete" if i>0
							end
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
