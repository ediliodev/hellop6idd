class ControlpnntsController < ApplicationController
  before_action :set_controlpnnt, only: [:show, :edit, :update, :destroy]

  # GET /controlpnnts
  # GET /controlpnnts.json
  def index

    @controlpnnts = Controlpnnt.all
    @controlpnntsb = Controlpnnt.all.order(:vendida => :desc)

  end

  # GET /controlpnnts/1
  # GET /controlpnnts/1.json
  def show
  end

  # GET /controlpnnts/new
  def new
    @controlpnnt = Controlpnnt.new
  end

  # GET /controlpnnts/1/edit
  def edit
  end

  # POST /controlpnnts
  # POST /controlpnnts.json
  def create
    @controlpnnt = Controlpnnt.new(controlpnnt_params)

    respond_to do |format|
      if @controlpnnt.save
        format.html { redirect_to @controlpnnt, notice: 'Controlpnnt was successfully created.' }
        format.json { render :show, status: :created, location: @controlpnnt }
      else
        format.html { render :new }
        format.json { render json: @controlpnnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controlpnnts/1
  # PATCH/PUT /controlpnnts/1.json
  def update
    respond_to do |format|
      if @controlpnnt.update(controlpnnt_params)
        format.html { redirect_to @controlpnnt, notice: 'Controlpnnt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controlpnnt }
      else
        format.html { render :edit }
        format.json { render json: @controlpnnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controlpnnts/1
  # DELETE /controlpnnts/1.json
  def destroy
    @controlpnnt.destroy
    respond_to do |format|
      format.html { redirect_to controlpnnts_url, notice: 'Controlpnnt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controlpnnt
      @controlpnnt = Controlpnnt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controlpnnt_params
      params.require(:controlpnnt).permit(:n1, :n2, :siglas, :limite, :vendida)
    end
end
