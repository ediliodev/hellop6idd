class ControlqleitsController < ApplicationController
  before_action :set_controlqleit, only: [:show, :edit, :update, :destroy]

  # GET /controlqleits
  # GET /controlqleits.json
  def index
    @controlqleits = Controlqleit.all
  end

  # GET /controlqleits/1
  # GET /controlqleits/1.json
  def show
  end

  # GET /controlqleits/new
  def new
    @controlqleit = Controlqleit.new
  end

  # GET /controlqleits/1/edit
  def edit
  end

  # POST /controlqleits
  # POST /controlqleits.json
  def create
    @controlqleit = Controlqleit.new(controlqleit_params)

    respond_to do |format|
      if @controlqleit.save
        format.html { redirect_to @controlqleit, notice: 'Controlqleit was successfully created.' }
        format.json { render :show, status: :created, location: @controlqleit }
      else
        format.html { render :new }
        format.json { render json: @controlqleit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controlqleits/1
  # PATCH/PUT /controlqleits/1.json
  def update
    respond_to do |format|
      if @controlqleit.update(controlqleit_params)
        format.html { redirect_to @controlqleit, notice: 'Controlqleit was successfully updated.' }
        format.json { render :show, status: :ok, location: @controlqleit }
      else
        format.html { render :edit }
        format.json { render json: @controlqleit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controlqleits/1
  # DELETE /controlqleits/1.json
  def destroy
    @controlqleit.destroy
    respond_to do |format|
      format.html { redirect_to controlqleits_url, notice: 'Controlqleit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controlqleit
      @controlqleit = Controlqleit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controlqleit_params
      params.require(:controlqleit).permit(:numero, :limite, :vendida)
    end
end
