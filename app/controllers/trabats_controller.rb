class TrabatsController < ApplicationController
  before_action :set_trabat, only: [:show, :edit, :update, :destroy]

  # GET /trabats
  # GET /trabats.json
  def index
    @trabats = Trabat.all
  end

  # GET /trabats/1
  # GET /trabats/1.json
  def show
  end

  # GET /trabats/new
  def new
    @trabat = Trabat.new
  end

  # GET /trabats/1/edit
  def edit
  end

  # POST /trabats
  # POST /trabats.json
  def create
    @trabat = Trabat.new(trabat_params)

    respond_to do |format|
      if @trabat.save
        format.html { redirect_to @trabat, notice: 'Trabat was successfully created.' }
        format.json { render :show, status: :created, location: @trabat }
      else
        format.html { render :new }
        format.json { render json: @trabat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trabats/1
  # PATCH/PUT /trabats/1.json
  def update
    respond_to do |format|
      if @trabat.update(trabat_params)
        format.html { redirect_to @trabat, notice: 'Trabat was successfully updated.' }
        format.json { render :show, status: :ok, location: @trabat }
      else
        format.html { render :edit }
        format.json { render json: @trabat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trabats/1
  # DELETE /trabats/1.json
  def destroy
    @trabat.destroy
    respond_to do |format|
      format.html { redirect_to trabats_url, notice: 'Trabat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trabat
      @trabat = Trabat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trabat_params
      params.require(:trabat).permit(:nombre, :descripcion)
    end
end
