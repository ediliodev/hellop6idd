class TipousuariotsController < ApplicationController
  before_action :set_tipousuariot, only: [:show, :edit, :update, :destroy]

  # GET /tipousuariots
  # GET /tipousuariots.json
  def index
    @tipousuariots = Tipousuariot.all
  end

  # GET /tipousuariots/1
  # GET /tipousuariots/1.json
  def show
  end

  # GET /tipousuariots/new
  def new
    @tipousuariot = Tipousuariot.new
  end

  # GET /tipousuariots/1/edit
  def edit
  end

  # POST /tipousuariots
  # POST /tipousuariots.json
  def create
    @tipousuariot = Tipousuariot.new(tipousuariot_params)

    respond_to do |format|
      if @tipousuariot.save
        format.html { redirect_to @tipousuariot, notice: 'Tipousuariot was successfully created.' }
        format.json { render :show, status: :created, location: @tipousuariot }
      else
        format.html { render :new }
        format.json { render json: @tipousuariot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipousuariots/1
  # PATCH/PUT /tipousuariots/1.json
  def update
    respond_to do |format|
      if @tipousuariot.update(tipousuariot_params)
        format.html { redirect_to @tipousuariot, notice: 'Tipousuariot was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipousuariot }
      else
        format.html { render :edit }
        format.json { render json: @tipousuariot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipousuariots/1
  # DELETE /tipousuariots/1.json
  def destroy
    @tipousuariot.destroy
    respond_to do |format|
      format.html { redirect_to tipousuariots_url, notice: 'Tipousuariot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipousuariot
      @tipousuariot = Tipousuariot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipousuariot_params
      params.require(:tipousuariot).permit(:tipo_usuario, :descripcion)
    end
end
