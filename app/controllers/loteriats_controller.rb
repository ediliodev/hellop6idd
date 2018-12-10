class LoteriatsController < ApplicationController
  before_action :set_loteriat, only: [:show, :edit, :update, :destroy]

  # GET /loteriats
  # GET /loteriats.json
  def index
    @loteriats = Loteriat.all
  end

  # GET /loteriats/1
  # GET /loteriats/1.json
  def show
  end

  # GET /loteriats/new
  def new
    @loteriat = Loteriat.new
  end

  # GET /loteriats/1/edit
  def edit
  end

  # POST /loteriats
  # POST /loteriats.json
  def create
    @loteriat = Loteriat.new(loteriat_params)

    respond_to do |format|
      if @loteriat.save
        format.html { redirect_to @loteriat, notice: 'Loteriat was successfully created.' }
        format.json { render :show, status: :created, location: @loteriat }
      else
        format.html { render :new }
        format.json { render json: @loteriat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loteriats/1
  # PATCH/PUT /loteriats/1.json
  def update
    respond_to do |format|
      if @loteriat.update(loteriat_params)
        format.html { redirect_to @loteriat, notice: 'Loteriat was successfully updated.' }
        format.json { render :show, status: :ok, location: @loteriat }
      else
        format.html { render :edit }
        format.json { render json: @loteriat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loteriats/1
  # DELETE /loteriats/1.json
  def destroy
    @loteriat.destroy
    respond_to do |format|
      format.html { redirect_to loteriats_url, notice: 'Loteriat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loteriat
      @loteriat = Loteriat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loteriat_params
      params.require(:loteriat).permit(:nombre, :descripcion, :paist_id)
    end
end
