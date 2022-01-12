class ConsorciotsController < ApplicationController
  before_action :set_consorciot, only: [:show, :edit, :update, :destroy]

  # GET /consorciots
  # GET /consorciots.json
  def index
    @consorciots = Consorciot.all
  end

  # GET /consorciots/1
  # GET /consorciots/1.json
  def show
  end

  # GET /consorciots/new
  def new
    @consorciot = Consorciot.new
  end

  # GET /consorciots/1/edit
  def edit
  end

  # POST /consorciots
  # POST /consorciots.json
  def create
    @consorciot = Consorciot.new(consorciot_params)

    respond_to do |format|
      if @consorciot.save
        format.html { redirect_to @consorciot, notice: 'Consorciot was successfully created.' }
        format.json { render :show, status: :created, location: @consorciot }
      else
        format.html { render :new }
        format.json { render json: @consorciot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /consorciots/1
  # PATCH/PUT /consorciots/1.json
  def update
    respond_to do |format|
      if @consorciot.update(consorciot_params)
        format.html { redirect_to @consorciot, notice: 'Consorciot was successfully updated.' }
        format.json { render :show, status: :ok, location: @consorciot }
      else
        format.html { render :edit }
        format.json { render json: @consorciot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consorciots/1
  # DELETE /consorciots/1.json
  def destroy
    @consorciot.destroy
    respond_to do |format|
      format.html { redirect_to consorciots_url, notice: 'Consorciot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consorciot
      @consorciot = Consorciot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def consorciot_params
      params.require(:consorciot).permit(:nombre, :abrebiatura, :telefono)
    end
end
