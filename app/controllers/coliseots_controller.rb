class ColiseotsController < ApplicationController
  before_action :set_coliseot, only: [:show, :edit, :update, :destroy]

  # GET /coliseots
  # GET /coliseots.json
  def index
    @coliseots = Coliseot.all
  end

  # GET /coliseots/1
  # GET /coliseots/1.json
  def show
  end

  # GET /coliseots/new
  def new
    @coliseot = Coliseot.new
  end

  # GET /coliseots/1/edit
  def edit
  end

  # POST /coliseots
  # POST /coliseots.json
  def create
    @coliseot = Coliseot.new(coliseot_params)

    respond_to do |format|
      if @coliseot.save
        format.html { redirect_to @coliseot, notice: 'Coliseot was successfully created.' }
        format.json { render :show, status: :created, location: @coliseot }
      else
        format.html { render :new }
        format.json { render json: @coliseot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coliseots/1
  # PATCH/PUT /coliseots/1.json
  def update
    respond_to do |format|
      if @coliseot.update(coliseot_params)
        format.html { redirect_to @coliseot, notice: 'Coliseot was successfully updated.' }
        format.json { render :show, status: :ok, location: @coliseot }
      else
        format.html { render :edit }
        format.json { render json: @coliseot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coliseots/1
  # DELETE /coliseots/1.json
  def destroy
    @coliseot.destroy
    respond_to do |format|
      format.html { redirect_to coliseots_url, notice: 'Coliseot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coliseot
      @coliseot = Coliseot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coliseot_params
      params.require(:coliseot).permit(:nombre, :descripcion)
    end
end
