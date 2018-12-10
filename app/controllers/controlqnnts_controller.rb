class ControlqnntsController < ApplicationController
  before_action :set_controlqnnt, only: [:show, :edit, :update, :destroy]

  # GET /controlqnnts
  # GET /controlqnnts.json
  def index
    @controlqnnts = Controlqnnt.all
  end

  # GET /controlqnnts/1
  # GET /controlqnnts/1.json
  def show
  end

  # GET /controlqnnts/new
  def new
    @controlqnnt = Controlqnnt.new
  end

  # GET /controlqnnts/1/edit
  def edit
  end

  # POST /controlqnnts
  # POST /controlqnnts.json
  def create
    @controlqnnt = Controlqnnt.new(controlqnnt_params)

    respond_to do |format|
      if @controlqnnt.save
        format.html { redirect_to @controlqnnt, notice: 'Controlqnnt was successfully created.' }
        format.json { render :show, status: :created, location: @controlqnnt }
      else
        format.html { render :new }
        format.json { render json: @controlqnnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controlqnnts/1
  # PATCH/PUT /controlqnnts/1.json
  def update
    respond_to do |format|
      if @controlqnnt.update(controlqnnt_params)
        format.html { redirect_to @controlqnnt, notice: 'Controlqnnt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controlqnnt }
      else
        format.html { render :edit }
        format.json { render json: @controlqnnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controlqnnts/1
  # DELETE /controlqnnts/1.json
  def destroy
    @controlqnnt.destroy
    respond_to do |format|
      format.html { redirect_to controlqnnts_url, notice: 'Controlqnnt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controlqnnt
      @controlqnnt = Controlqnnt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controlqnnt_params
      params.require(:controlqnnt).permit(:numero, :limite, :vendida)
    end
end
