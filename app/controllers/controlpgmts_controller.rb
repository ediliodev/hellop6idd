class ControlpgmtsController < ApplicationController
  before_action :set_controlpgmt, only: [:show, :edit, :update, :destroy]

  # GET /controlpgmts
  # GET /controlpgmts.json
  def index
    @controlpgmts = Controlpgmt.all
  end

  # GET /controlpgmts/1
  # GET /controlpgmts/1.json
  def show
  end

  # GET /controlpgmts/new
  def new
    @controlpgmt = Controlpgmt.new
  end

  # GET /controlpgmts/1/edit
  def edit
  end

  # POST /controlpgmts
  # POST /controlpgmts.json
  def create
    @controlpgmt = Controlpgmt.new(controlpgmt_params)

    respond_to do |format|
      if @controlpgmt.save
        format.html { redirect_to @controlpgmt, notice: 'Controlpgmt was successfully created.' }
        format.json { render :show, status: :created, location: @controlpgmt }
      else
        format.html { render :new }
        format.json { render json: @controlpgmt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controlpgmts/1
  # PATCH/PUT /controlpgmts/1.json
  def update
    respond_to do |format|
      if @controlpgmt.update(controlpgmt_params)
        format.html { redirect_to @controlpgmt, notice: 'Controlpgmt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controlpgmt }
      else
        format.html { render :edit }
        format.json { render json: @controlpgmt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controlpgmts/1
  # DELETE /controlpgmts/1.json
  def destroy
    @controlpgmt.destroy
    respond_to do |format|
      format.html { redirect_to controlpgmts_url, notice: 'Controlpgmt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controlpgmt
      @controlpgmt = Controlpgmt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controlpgmt_params
      params.require(:controlpgmt).permit(:n1, :n2, :siglas, :limite, :vendida)
    end
end
