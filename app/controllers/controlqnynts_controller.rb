class ControlqnyntsController < ApplicationController
  before_action :set_controlqnynt, only: [:show, :edit, :update, :destroy]

  # GET /controlqnynts
  # GET /controlqnynts.json
  def index
    @controlqnynts = Controlqnynt.all
  end

  # GET /controlqnynts/1
  # GET /controlqnynts/1.json
  def show
  end

  # GET /controlqnynts/new
  def new
    @controlqnynt = Controlqnynt.new
  end

  # GET /controlqnynts/1/edit
  def edit
  end

  # POST /controlqnynts
  # POST /controlqnynts.json
  def create
    @controlqnynt = Controlqnynt.new(controlqnynt_params)

    respond_to do |format|
      if @controlqnynt.save
        format.html { redirect_to @controlqnynt, notice: 'Controlqnynt was successfully created.' }
        format.json { render :show, status: :created, location: @controlqnynt }
      else
        format.html { render :new }
        format.json { render json: @controlqnynt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controlqnynts/1
  # PATCH/PUT /controlqnynts/1.json
  def update
    respond_to do |format|
      if @controlqnynt.update(controlqnynt_params)
        format.html { redirect_to @controlqnynt, notice: 'Controlqnynt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controlqnynt }
      else
        format.html { render :edit }
        format.json { render json: @controlqnynt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controlqnynts/1
  # DELETE /controlqnynts/1.json
  def destroy
    @controlqnynt.destroy
    respond_to do |format|
      format.html { redirect_to controlqnynts_url, notice: 'Controlqnynt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controlqnynt
      @controlqnynt = Controlqnynt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controlqnynt_params
      params.require(:controlqnynt).permit(:numero, :limite, :vendida)
    end
end
