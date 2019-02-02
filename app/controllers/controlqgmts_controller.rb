class ControlqgmtsController < ApplicationController
  before_action :set_controlqgmt, only: [:show, :edit, :update, :destroy]

  # GET /controlqgmts
  # GET /controlqgmts.json
  def index
    @controlqgmts = Controlqgmt.all
    @controlqgmtsb = Controlqgmt.all.order(:vendida => :desc)

  end

  # GET /controlqgmts/1
  # GET /controlqgmts/1.json
  def show
  end

  # GET /controlqgmts/new
  def new
    @controlqgmt = Controlqgmt.new
  end

  # GET /controlqgmts/1/edit
  def edit
  end

  # POST /controlqgmts
  # POST /controlqgmts.json
  def create
    @controlqgmt = Controlqgmt.new(controlqgmt_params)

    respond_to do |format|
      if @controlqgmt.save
        format.html { redirect_to @controlqgmt, notice: 'Controlqgmt was successfully created.' }
        format.json { render :show, status: :created, location: @controlqgmt }
      else
        format.html { render :new }
        format.json { render json: @controlqgmt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controlqgmts/1
  # PATCH/PUT /controlqgmts/1.json
  def update
    respond_to do |format|
      if @controlqgmt.update(controlqgmt_params)
        format.html { redirect_to @controlqgmt, notice: 'Controlqgmt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controlqgmt }
      else
        format.html { render :edit }
        format.json { render json: @controlqgmt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controlqgmts/1
  # DELETE /controlqgmts/1.json
  def destroy
    @controlqgmt.destroy
    respond_to do |format|
      format.html { redirect_to controlqgmts_url, notice: 'Controlqgmt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controlqgmt
      @controlqgmt = Controlqgmt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controlqgmt_params
      params.require(:controlqgmt).permit(:numero, :limite, :vendida)
    end
end
