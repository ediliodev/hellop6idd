class ControlspltknntsController < ApplicationController
  before_action :set_controlspltknnt, only: [:show, :edit, :update, :destroy]

  # GET /controlspltknnts
  # GET /controlspltknnts.json
  def index
    @controlspltknnts = Controlspltknnt.all
    @controlspltknntsb = Controlspltknnt.all.order(:vendida => :desc)
  end

  # GET /controlspltknnts/1
  # GET /controlspltknnts/1.json
  def show
  end

  # GET /controlspltknnts/new
  def new
    @controlspltknnt = Controlspltknnt.new
  end

  # GET /controlspltknnts/1/edit
  def edit
  end

  # POST /controlspltknnts
  # POST /controlspltknnts.json
  def create
    @controlspltknnt = Controlspltknnt.new(controlspltknnt_params)

    respond_to do |format|
      if @controlspltknnt.save
        format.html { redirect_to @controlspltknnt, notice: 'Controlspltknnt was successfully created.' }
        format.json { render :show, status: :created, location: @controlspltknnt }
      else
        format.html { render :new }
        format.json { render json: @controlspltknnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controlspltknnts/1
  # PATCH/PUT /controlspltknnts/1.json
  def update
    respond_to do |format|
      if @controlspltknnt.update(controlspltknnt_params)
        format.html { redirect_to @controlspltknnt, notice: 'Controlspltknnt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controlspltknnt }
      else
        format.html { render :edit }
        format.json { render json: @controlspltknnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controlspltknnts/1
  # DELETE /controlspltknnts/1.json
  def destroy
    @controlspltknnt.destroy
    respond_to do |format|
      format.html { redirect_to controlspltknnts_url, notice: 'Controlspltknnt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controlspltknnt
      @controlspltknnt = Controlspltknnt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controlspltknnt_params
      params.require(:controlspltknnt).permit(:n1, :n2, :siglas, :limite, :vendida)
    end
end
