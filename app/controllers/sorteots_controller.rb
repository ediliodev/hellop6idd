class SorteotsController < ApplicationController
  before_action :set_sorteot, only: [:show, :edit, :update, :destroy]

  # GET /sorteots
  # GET /sorteots.json
  def index
    @sorteots = Sorteot.all
  end

  # GET /sorteots/1
  # GET /sorteots/1.json
  def show
  end

  # GET /sorteots/new
  def new
    @sorteot = Sorteot.new
  end

  # GET /sorteots/1/edit
  def edit
  end

  # POST /sorteots
  # POST /sorteots.json
  def create
    @sorteot = Sorteot.new(sorteot_params)

    respond_to do |format|
      if @sorteot.save
        format.html { redirect_to @sorteot, notice: 'Sorteot was successfully created.' }
        format.json { render :show, status: :created, location: @sorteot }
      else
        format.html { render :new }
        format.json { render json: @sorteot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sorteots/1
  # PATCH/PUT /sorteots/1.json
  def update
    respond_to do |format|
      if @sorteot.update(sorteot_params)
        format.html { redirect_to @sorteot, notice: 'Sorteot was successfully updated.' }
        format.json { render :show, status: :ok, location: @sorteot }
      else
        format.html { render :edit }
        format.json { render json: @sorteot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sorteots/1
  # DELETE /sorteots/1.json
  def destroy
    @sorteot.destroy
    respond_to do |format|
      format.html { redirect_to sorteots_url, notice: 'Sorteot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sorteot
      @sorteot = Sorteot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sorteot_params
      params.require(:sorteot).permit(:nombre, :descripcion, :sigla, :abreviaturamovil, :horariosorteot_id, :loteriat_id, :activo, :abierto)
    end
end
