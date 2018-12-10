class ControlpnyttsController < ApplicationController
  before_action :set_controlpnytt, only: [:show, :edit, :update, :destroy]

  # GET /controlpnytts
  # GET /controlpnytts.json
  def index
    @controlpnytts = Controlpnytt.all
  end

  # GET /controlpnytts/1
  # GET /controlpnytts/1.json
  def show
  end

  # GET /controlpnytts/new
  def new
    @controlpnytt = Controlpnytt.new
  end

  # GET /controlpnytts/1/edit
  def edit
  end

  # POST /controlpnytts
  # POST /controlpnytts.json
  def create
    @controlpnytt = Controlpnytt.new(controlpnytt_params)

    respond_to do |format|
      if @controlpnytt.save
        format.html { redirect_to @controlpnytt, notice: 'Controlpnytt was successfully created.' }
        format.json { render :show, status: :created, location: @controlpnytt }
      else
        format.html { render :new }
        format.json { render json: @controlpnytt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controlpnytts/1
  # PATCH/PUT /controlpnytts/1.json
  def update
    respond_to do |format|
      if @controlpnytt.update(controlpnytt_params)
        format.html { redirect_to @controlpnytt, notice: 'Controlpnytt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controlpnytt }
      else
        format.html { render :edit }
        format.json { render json: @controlpnytt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controlpnytts/1
  # DELETE /controlpnytts/1.json
  def destroy
    @controlpnytt.destroy
    respond_to do |format|
      format.html { redirect_to controlpnytts_url, notice: 'Controlpnytt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controlpnytt
      @controlpnytt = Controlpnytt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controlpnytt_params
      params.require(:controlpnytt).permit(:n1, :n2, :siglas, :limite, :vendida)
    end
end
