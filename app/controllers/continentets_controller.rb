class ContinentetsController < ApplicationController
  before_action :set_continentet, only: [:show, :edit, :update, :destroy]

  # GET /continentets
  # GET /continentets.json
  def index
    @continentets = Continentet.all
  end

  # GET /continentets/1
  # GET /continentets/1.json
  def show
  end

  # GET /continentets/new
  def new
    @continentet = Continentet.new
  end

  # GET /continentets/1/edit
  def edit
  end

  # POST /continentets
  # POST /continentets.json
  def create
    @continentet = Continentet.new(continentet_params)

    respond_to do |format|
      if @continentet.save
        format.html { redirect_to @continentet, notice: 'Continentet was successfully created.' }
        format.json { render :show, status: :created, location: @continentet }
      else
        format.html { render :new }
        format.json { render json: @continentet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /continentets/1
  # PATCH/PUT /continentets/1.json
  def update
    respond_to do |format|
      if @continentet.update(continentet_params)
        format.html { redirect_to @continentet, notice: 'Continentet was successfully updated.' }
        format.json { render :show, status: :ok, location: @continentet }
      else
        format.html { render :edit }
        format.json { render json: @continentet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /continentets/1
  # DELETE /continentets/1.json
  def destroy
    @continentet.destroy
    respond_to do |format|
      format.html { redirect_to continentets_url, notice: 'Continentet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_continentet
      @continentet = Continentet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def continentet_params
      params.require(:continentet).permit(:nombre, :descripcion)
    end
end
