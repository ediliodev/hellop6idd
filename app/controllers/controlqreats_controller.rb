class ControlqreatsController < ApplicationController
  before_action :set_controlqreat, only: [:show, :edit, :update, :destroy]

  # GET /controlqreats
  # GET /controlqreats.json
  def index
    @controlqreats = Controlqreat.all
  end

  # GET /controlqreats/1
  # GET /controlqreats/1.json
  def show
  end

  # GET /controlqreats/new
  def new
    @controlqreat = Controlqreat.new
  end

  # GET /controlqreats/1/edit
  def edit
  end

  # POST /controlqreats
  # POST /controlqreats.json
  def create
    @controlqreat = Controlqreat.new(controlqreat_params)

    respond_to do |format|
      if @controlqreat.save
        format.html { redirect_to @controlqreat, notice: 'Controlqreat was successfully created.' }
        format.json { render :show, status: :created, location: @controlqreat }
      else
        format.html { render :new }
        format.json { render json: @controlqreat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controlqreats/1
  # PATCH/PUT /controlqreats/1.json
  def update
    respond_to do |format|
      if @controlqreat.update(controlqreat_params)
        format.html { redirect_to @controlqreat, notice: 'Controlqreat was successfully updated.' }
        format.json { render :show, status: :ok, location: @controlqreat }
      else
        format.html { render :edit }
        format.json { render json: @controlqreat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controlqreats/1
  # DELETE /controlqreats/1.json
  def destroy
    @controlqreat.destroy
    respond_to do |format|
      format.html { redirect_to controlqreats_url, notice: 'Controlqreat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controlqreat
      @controlqreat = Controlqreat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controlqreat_params
      params.require(:controlqreat).permit(:numero, :limite, :vendida)
    end
end
