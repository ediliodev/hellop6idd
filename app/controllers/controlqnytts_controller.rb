class ControlqnyttsController < ApplicationController
  before_action :set_controlqnytt, only: [:show, :edit, :update, :destroy]

  # GET /controlqnytts
  # GET /controlqnytts.json
  def index
    @controlqnytts = Controlqnytt.all
    @controlqnyttsb = Controlqnytt.all.order(:vendida => :desc)
  end

  # GET /controlqnytts/1
  # GET /controlqnytts/1.json
  def show
  end

  # GET /controlqnytts/new
  def new
    @controlqnytt = Controlqnytt.new
  end

  # GET /controlqnytts/1/edit
  def edit
  end

  # POST /controlqnytts
  # POST /controlqnytts.json
  def create
    @controlqnytt = Controlqnytt.new(controlqnytt_params)

    respond_to do |format|
      if @controlqnytt.save
        format.html { redirect_to @controlqnytt, notice: 'Controlqnytt was successfully created.' }
        format.json { render :show, status: :created, location: @controlqnytt }
      else
        format.html { render :new }
        format.json { render json: @controlqnytt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controlqnytts/1
  # PATCH/PUT /controlqnytts/1.json
  def update
    respond_to do |format|
      if @controlqnytt.update(controlqnytt_params)
        format.html { redirect_to @controlqnytt, notice: 'Controlqnytt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controlqnytt }
      else
        format.html { render :edit }
        format.json { render json: @controlqnytt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controlqnytts/1
  # DELETE /controlqnytts/1.json
  def destroy
    @controlqnytt.destroy
    respond_to do |format|
      format.html { redirect_to controlqnytts_url, notice: 'Controlqnytt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controlqnytt
      @controlqnytt = Controlqnytt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controlqnytt_params
      params.require(:controlqnytt).permit(:numero, :limite, :vendida)
    end
end
