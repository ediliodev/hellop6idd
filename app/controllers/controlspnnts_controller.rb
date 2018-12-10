class ControlspnntsController < ApplicationController
  before_action :set_controlspnnt, only: [:show, :edit, :update, :destroy]

  # GET /controlspnnts
  # GET /controlspnnts.json
  def index
    @controlspnnts = Controlspnnt.all
  end

  # GET /controlspnnts/1
  # GET /controlspnnts/1.json
  def show
  end

  # GET /controlspnnts/new
  def new
    @controlspnnt = Controlspnnt.new
  end

  # GET /controlspnnts/1/edit
  def edit
  end

  # POST /controlspnnts
  # POST /controlspnnts.json
  def create
    @controlspnnt = Controlspnnt.new(controlspnnt_params)

    respond_to do |format|
      if @controlspnnt.save
        format.html { redirect_to @controlspnnt, notice: 'Controlspnnt was successfully created.' }
        format.json { render :show, status: :created, location: @controlspnnt }
      else
        format.html { render :new }
        format.json { render json: @controlspnnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controlspnnts/1
  # PATCH/PUT /controlspnnts/1.json
  def update
    respond_to do |format|
      if @controlspnnt.update(controlspnnt_params)
        format.html { redirect_to @controlspnnt, notice: 'Controlspnnt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controlspnnt }
      else
        format.html { render :edit }
        format.json { render json: @controlspnnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controlspnnts/1
  # DELETE /controlspnnts/1.json
  def destroy
    @controlspnnt.destroy
    respond_to do |format|
      format.html { redirect_to controlspnnts_url, notice: 'Controlspnnt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controlspnnt
      @controlspnnt = Controlspnnt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controlspnnt_params
      params.require(:controlspnnt).permit(:n1, :n2, :siglas, :limite, :vendida)
    end
end
