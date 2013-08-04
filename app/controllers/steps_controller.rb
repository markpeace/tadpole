class StepsController < ApplicationController
  before_action :set_step, only: [:show, :edit, :update, :destroy, :move]

  # GET /steps
  # GET /steps.json
  def index
	@brew=Brew.find(params[:brew])
	redirect_to root_path unless @brew.user==current_user
    @steps = Step.where(:brew=>@brew).order("[order] ASC")
  end

  # GET /steps/1
  # GET /steps/1.json
  def show
  end

  # GET /steps/new
  def new
    @step = Step.new
	@step.user=current_user
	@step.brew_id=params[:brew]
  end

  # GET /steps/1/edit
  def edit
  end

  # POST /steps
  # POST /steps.json
  def create
    @step = Step.new(step_params)

    respond_to do |format|
      if @step.save
        format.html { redirect_to steps_path(:brew=>@step.brew_id), notice: 'Step was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /steps/1
  # PATCH/PUT /steps/1.json
  def update
    respond_to do |format|
      if @step.update(step_params)
        format.html { redirect_to @step, notice: 'Step was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /steps/1
  # DELETE /steps/1.json
  def destroy
    @step.destroy
    respond_to do |format|
      format.html { redirect_to steps_url }
      format.json { head :no_content }
    end
  end

  def move
	@step.move(params[:direction].to_sym)
	redirect_to steps_path(:brew=>@step.brew.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_step
      @step = Step.find(params[:id])
	  redirect_to root_path unless @step.user=current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def step_params
      params.require(:step).permit(:user_id, :brew_id, :title, :days, :order, :date, :completed, :update_inventory)
    end
end
