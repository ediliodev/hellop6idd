class DirecciontsController < ApplicationController
  before_action :set_direcciont, only: [:show, :edit, :update, :destroy]

  # GET /direccionts
  # GET /direccionts.json
  def index
    @direccionts = Direcciont.all
  end

  # GET /direccionts/1
  # GET /direccionts/1.json
  def show
  end

  # GET /direccionts/new
  def new
    @direcciont = Direcciont.new
  end

  # GET /direccionts/1/edit
  def edit
  end

  # POST /direccionts
  # POST /direccionts.json
  def create
    @direcciont = Direcciont.new(direcciont_params)

    respond_to do |format|
      if @direcciont.save
        format.html { redirect_to @direcciont, notice: 'Direcciont was successfully created.' }
        format.json { render :show, status: :created, location: @direcciont }
      else
        format.html { render :new }
        format.json { render json: @direcciont.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /direccionts/1
  # PATCH/PUT /direccionts/1.json
  def update
    respond_to do |format|
      if @direcciont.update(direcciont_params)
        format.html { redirect_to @direcciont, notice: 'Direcciont was successfully updated.' }
        format.json { render :show, status: :ok, location: @direcciont }
      else
        format.html { render :edit }
        format.json { render json: @direcciont.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /direccionts/1
  # DELETE /direccionts/1.json
  def destroy
    @direcciont.destroy
    respond_to do |format|
      format.html { redirect_to direccionts_url, notice: 'Direcciont was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_direcciont
      @direcciont = Direcciont.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def direcciont_params
      params.require(:direcciont).permit(:direccion, :sector, :cuidadt_id)
    end
end
