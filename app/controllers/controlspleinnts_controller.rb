class ControlspleinntsController < ApplicationController
  before_action :set_controlspleinnt, only: [:show, :edit, :update, :destroy]

  # GET /controlspleinnts
  # GET /controlspleinnts.json
  def index
    @controlspleinnts = Controlspleinnt.all
    @controlspleinntsb = Controlspleinnt.all.order(:vendida => :desc)

  end

  # GET /controlspleinnts/1
  # GET /controlspleinnts/1.json
  def show
  end

  # GET /controlspleinnts/new
  def new
    @controlspleinnt = Controlspleinnt.new
  end

  # GET /controlspleinnts/1/edit
  def edit
  end

  # POST /controlspleinnts
  # POST /controlspleinnts.json
  def create
    @controlspleinnt = Controlspleinnt.new(controlspleinnt_params)

    respond_to do |format|
      if @controlspleinnt.save
        format.html { redirect_to @controlspleinnt, notice: 'Controlspleinnt was successfully created.' }
        format.json { render :show, status: :created, location: @controlspleinnt }
      else
        format.html { render :new }
        format.json { render json: @controlspleinnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controlspleinnts/1
  # PATCH/PUT /controlspleinnts/1.json
  def update
    respond_to do |format|
      if @controlspleinnt.update(controlspleinnt_params)
        format.html { redirect_to @controlspleinnt, notice: 'Controlspleinnt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controlspleinnt }
      else
        format.html { render :edit }
        format.json { render json: @controlspleinnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controlspleinnts/1
  # DELETE /controlspleinnts/1.json
  def destroy
    @controlspleinnt.destroy
    respond_to do |format|
      format.html { redirect_to controlspleinnts_url, notice: 'Controlspleinnt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controlspleinnt
      @controlspleinnt = Controlspleinnt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controlspleinnt_params
      params.require(:controlspleinnt).permit(:n1, :n2, :siglas, :limite, :vendida)
    end
end
