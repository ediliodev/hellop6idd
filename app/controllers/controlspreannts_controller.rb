class ControlspreanntsController < ApplicationController
  before_action :set_controlspreannt, only: [:show, :edit, :update, :destroy]

  # GET /controlspreannts
  # GET /controlspreannts.json
  def index
    @controlspreannts = Controlspreannt.all
    @controlspreanntsb = Controlspreannt.all.order(:vendida => :desc)

  end

  # GET /controlspreannts/1
  # GET /controlspreannts/1.json
  def show
  end

  # GET /controlspreannts/new
  def new
    @controlspreannt = Controlspreannt.new
  end

  # GET /controlspreannts/1/edit
  def edit
  end

  # POST /controlspreannts
  # POST /controlspreannts.json
  def create
    @controlspreannt = Controlspreannt.new(controlspreannt_params)

    respond_to do |format|
      if @controlspreannt.save
        format.html { redirect_to @controlspreannt, notice: 'Controlspreannt was successfully created.' }
        format.json { render :show, status: :created, location: @controlspreannt }
      else
        format.html { render :new }
        format.json { render json: @controlspreannt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controlspreannts/1
  # PATCH/PUT /controlspreannts/1.json
  def update
    respond_to do |format|
      if @controlspreannt.update(controlspreannt_params)
        format.html { redirect_to @controlspreannt, notice: 'Controlspreannt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controlspreannt }
      else
        format.html { render :edit }
        format.json { render json: @controlspreannt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controlspreannts/1
  # DELETE /controlspreannts/1.json
  def destroy
    @controlspreannt.destroy
    respond_to do |format|
      format.html { redirect_to controlspreannts_url, notice: 'Controlspreannt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controlspreannt
      @controlspreannt = Controlspreannt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controlspreannt_params
      params.require(:controlspreannt).permit(:n1, :n2, :siglas, :limite, :vendida)
    end
end
