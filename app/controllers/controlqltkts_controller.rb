class ControlqltktsController < ApplicationController
  before_action :set_controlqltkt, only: [:show, :edit, :update, :destroy]

  # GET /controlqltkts
  # GET /controlqltkts.json
  def index
    @controlqltkts = Controlqltkt.all
    @controlqltktsb = Controlqltkt.all.order(:vendida => :desc)
  end

  # GET /controlqltkts/1
  # GET /controlqltkts/1.json
  def show
  end

  # GET /controlqltkts/new
  def new
    @controlqltkt = Controlqltkt.new
  end

  # GET /controlqltkts/1/edit
  def edit
  end

  # POST /controlqltkts
  # POST /controlqltkts.json
  def create
    @controlqltkt = Controlqltkt.new(controlqltkt_params)

    respond_to do |format|
      if @controlqltkt.save
        format.html { redirect_to @controlqltkt, notice: 'Controlqltkt was successfully created.' }
        format.json { render :show, status: :created, location: @controlqltkt }
      else
        format.html { render :new }
        format.json { render json: @controlqltkt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controlqltkts/1
  # PATCH/PUT /controlqltkts/1.json
  def update
    respond_to do |format|
      if @controlqltkt.update(controlqltkt_params)
        format.html { redirect_to @controlqltkt, notice: 'Controlqltkt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controlqltkt }
      else
        format.html { render :edit }
        format.json { render json: @controlqltkt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controlqltkts/1
  # DELETE /controlqltkts/1.json
  def destroy
    @controlqltkt.destroy
    respond_to do |format|
      format.html { redirect_to controlqltkts_url, notice: 'Controlqltkt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controlqltkt
      @controlqltkt = Controlqltkt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controlqltkt_params
      params.require(:controlqltkt).permit(:numero, :limite, :vendida)
    end
end
