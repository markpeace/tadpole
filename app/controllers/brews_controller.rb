class BrewsController < ApplicationController
  before_action :set_brew, only: [:show, :edit, :update, :destroy, :setdate]

  # GET /brews
  # GET /brews.json
  def index
    @brews = current_user.brews.order('date DESC')
	@tasks = current_user.steps.where('completed=? OR date>?', false, Date.today).order(:date)
  end

  # GET /brews/new
  def new
    @brew = Brew.new
	@brew.user=current_user
  end

  # GET /brews/1/edit
  def edit
  end

  # POST /brews
  # POST /brews.json
  def create
    @brew = Brew.new(brew_params)

    respond_to do |format|
      if @brew.save
        format.html { redirect_to Brew, notice: 'Brew was successfully created.' }
        format.json { render action: 'show', status: :created, location: @brew }
      else
        format.html { render action: 'new' }
        format.json { render json: @brew.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brews/1
  # PATCH/PUT /brews/1.json
  def update
    respond_to do |format|
      if @brew.update(brew_params)
        format.html { redirect_to Brew, notice: 'Brew was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @brew.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brews/1
  # DELETE /brews/1.json
  def destroy
    @brew.destroy
    respond_to do |format|
      format.html { redirect_to brews_url }
      format.json { head :no_content }
    end
  end

  def setdate
	@brew.update_attributes(:date=>Date.today, :brewed=>true)
	@brew.steps.first.autocalculate_dates
	redirect_to steps_path(:brew=>@brew.id)
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brew
      @brew = Brew.find(params[:id])
	  redirect_to root_path unless @brew.user==current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brew_params
      params.require(:brew).permit(:user_id, :name, :date, :brewed)
    end
end
