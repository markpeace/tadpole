class CalendarController < ApplicationController

	skip_before_filter :authenticate_user!
	
	include Icalendar
	
	def index
		user=User.find(params[:id])
		respond_to do |format|
			format.html do
				@steps=Step.where(:user_id=>params[:id], :completed=>false).order("date DESC")
				render :index
			end
			format.ics do
				r=root_url
				cal = Calendar.new
			
				user.brews.each do |b|
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
								if i>0 then
									description "You cannot complete this step as prior ones are still incomplete"
								else
									if s.order==1 then
										description "Click this link to mark step as complete: 
													#{r}brews/#{s.brew.id}/setdate"
									else
										description "Click this link to mark step as complete: #{r}steps/#{id}/complete"
									end
								end
							end
							id=s.id
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
