class MonedatsController < ApplicationController
  before_action :set_monedat, only: [:show, :edit, :update, :destroy]

  # GET /monedats
  # GET /monedats.json
  def index
    @monedats = Monedat.all
  end

  # GET /monedats/1
  # GET /monedats/1.json
  def show
  end

  # GET /monedats/new
  def new
    @monedat = Monedat.new
  end

  # GET /monedats/1/edit
  def edit
  end

  # POST /monedats
  # POST /monedats.json
  def create
    @monedat = Monedat.new(monedat_params)

    respond_to do |format|
      if @monedat.save
        format.html { redirect_to @monedat, notice: 'Monedat was successfully created.' }
        format.json { render :show, status: :created, location: @monedat }
      else
        format.html { render :new }
        format.json { render json: @monedat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /monedats/1
  # PATCH/PUT /monedats/1.json
  def update
    respond_to do |format|
      if @monedat.update(monedat_params)
        format.html { redirect_to @monedat, notice: 'Monedat was successfully updated.' }
        format.json { render :show, status: :ok, location: @monedat }
      else
        format.html { render :edit }
        format.json { render json: @monedat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monedats/1
  # DELETE /monedats/1.json
  def destroy
    @monedat.destroy
    respond_to do |format|
      format.html { redirect_to monedats_url, notice: 'Monedat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monedat
      @monedat = Monedat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def monedat_params
      params.require(:monedat).permit(:simbolo, :nombre, :descripcion, :paist_id)
    end
end
