class ControlpltktsController < ApplicationController
  before_action :set_controlpltkt, only: [:show, :edit, :update, :destroy]

  # GET /controlpltkts
  # GET /controlpltkts.json
  def index
    @controlpltkts = Controlpltkt.all
  end

  # GET /controlpltkts/1
  # GET /controlpltkts/1.json
  def show
  end

  # GET /controlpltkts/new
  def new
    @controlpltkt = Controlpltkt.new
  end

  # GET /controlpltkts/1/edit
  def edit
  end

  # POST /controlpltkts
  # POST /controlpltkts.json
  def create
    @controlpltkt = Controlpltkt.new(controlpltkt_params)

    respond_to do |format|
      if @controlpltkt.save
        format.html { redirect_to @controlpltkt, notice: 'Controlpltkt was successfully created.' }
        format.json { render :show, status: :created, location: @controlpltkt }
      else
        format.html { render :new }
        format.json { render json: @controlpltkt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controlpltkts/1
  # PATCH/PUT /controlpltkts/1.json
  def update
    respond_to do |format|
      if @controlpltkt.update(controlpltkt_params)
        format.html { redirect_to @controlpltkt, notice: 'Controlpltkt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controlpltkt }
      else
        format.html { render :edit }
        format.json { render json: @controlpltkt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controlpltkts/1
  # DELETE /controlpltkts/1.json
  def destroy
    @controlpltkt.destroy
    respond_to do |format|
      format.html { redirect_to controlpltkts_url, notice: 'Controlpltkt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controlpltkt
      @controlpltkt = Controlpltkt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controlpltkt_params
      params.require(:controlpltkt).permit(:n1, :n2, :siglas, :limite, :vendida)
    end
end
