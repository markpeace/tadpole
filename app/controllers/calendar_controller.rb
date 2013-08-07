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
				prev_id=-1
				cal = Calendar.new
			
				user.brews.each do |b|
					steps=b.steps.where(:completed=>false).order("date ASC")
					if steps.count>0 then
						cal.event do
							dtstart	b.date
							dtend b.date
							summary "Brew #{b.name}"
						end unless b.brewed

						steps.each_with_index do |s,i|
							cal.event do |c|
								c.dtstart	s.date
								c.dtend s.date
								c.summary "#{b.name} to #{s.title} for #{s.days} days"
								if (s.brew.brewed and i>1) or (!s.brew.brewed and i>0) then
									c.description "You cannot complete this step until previous ones are complete"
								else
									if s.steporder==1 then
										c.description "Click this link to mark step as complete: 
													#{r}brews/#{s.brew.id}/setdate"										
									else
										c.description "Click this link to mark step as complete: 
													#{r}steps/#{prev_id}/complete"
									end
								end
							end unless s.brew.brewed==true and i==0
							prev_id=s.id

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
