class ControlpnyntsController < ApplicationController
  before_action :set_controlpnynt, only: [:show, :edit, :update, :destroy]

  # GET /controlpnynts
  # GET /controlpnynts.json
  def index
    @controlpnynts = Controlpnynt.all
  end

  # GET /controlpnynts/1
  # GET /controlpnynts/1.json
  def show
  end

  # GET /controlpnynts/new
  def new
    @controlpnynt = Controlpnynt.new
  end

  # GET /controlpnynts/1/edit
  def edit
  end

  # POST /controlpnynts
  # POST /controlpnynts.json
  def create
    @controlpnynt = Controlpnynt.new(controlpnynt_params)

    respond_to do |format|
      if @controlpnynt.save
        format.html { redirect_to @controlpnynt, notice: 'Controlpnynt was successfully created.' }
        format.json { render :show, status: :created, location: @controlpnynt }
      else
        format.html { render :new }
        format.json { render json: @controlpnynt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controlpnynts/1
  # PATCH/PUT /controlpnynts/1.json
  def update
    respond_to do |format|
      if @controlpnynt.update(controlpnynt_params)
        format.html { redirect_to @controlpnynt, notice: 'Controlpnynt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controlpnynt }
      else
        format.html { render :edit }
        format.json { render json: @controlpnynt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controlpnynts/1
  # DELETE /controlpnynts/1.json
  def destroy
    @controlpnynt.destroy
    respond_to do |format|
      format.html { redirect_to controlpnynts_url, notice: 'Controlpnynt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controlpnynt
      @controlpnynt = Controlpnynt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controlpnynt_params
      params.require(:controlpnynt).permit(:n1, :n2, :siglas, :limite, :vendida)
    end
end
