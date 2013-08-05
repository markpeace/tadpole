class CalendarController < ApplicationController

	skip_before_filter :authenticate_user!
	
	def index
		@steps=Step.where(:user_id=>params[:id])
		respond_to do |format|
			format.html { render :index }
			format.ics do
				render :index
			end
		end
	end
	
end
