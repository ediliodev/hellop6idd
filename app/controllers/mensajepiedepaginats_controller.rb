class MensajepiedepaginatsController < ApplicationController
  before_action :set_mensajepiedepaginat, only: [:show, :edit, :update, :destroy]

  # GET /mensajepiedepaginats
  # GET /mensajepiedepaginats.json
  def index
    @mensajepiedepaginats = Mensajepiedepaginat.all
  end

  # GET /mensajepiedepaginats/1
  # GET /mensajepiedepaginats/1.json
  def show
  end

  # GET /mensajepiedepaginats/new
  def new
    @mensajepiedepaginat = Mensajepiedepaginat.new
  end

  # GET /mensajepiedepaginats/1/edit
  def edit
  end

  # POST /mensajepiedepaginats
  # POST /mensajepiedepaginats.json
  def create
    @mensajepiedepaginat = Mensajepiedepaginat.new(mensajepiedepaginat_params)

    respond_to do |format|
      if @mensajepiedepaginat.save
        format.html { redirect_to @mensajepiedepaginat, notice: 'Mensajepiedepaginat was successfully created.' }
        format.json { render :show, status: :created, location: @mensajepiedepaginat }
      else
        format.html { render :new }
        format.json { render json: @mensajepiedepaginat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mensajepiedepaginats/1
  # PATCH/PUT /mensajepiedepaginats/1.json
  def update
    respond_to do |format|
      if @mensajepiedepaginat.update(mensajepiedepaginat_params)
        format.html { redirect_to @mensajepiedepaginat, notice: 'Mensajepiedepaginat was successfully updated.' }
        format.json { render :show, status: :ok, location: @mensajepiedepaginat }
      else
        format.html { render :edit }
        format.json { render json: @mensajepiedepaginat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mensajepiedepaginats/1
  # DELETE /mensajepiedepaginats/1.json
  def destroy
    @mensajepiedepaginat.destroy
    respond_to do |format|
      format.html { redirect_to mensajepiedepaginats_url, notice: 'Mensajepiedepaginat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mensajepiedepaginat
      @mensajepiedepaginat = Mensajepiedepaginat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mensajepiedepaginat_params
      params.require(:mensajepiedepaginat).permit(:tipodemensaje, :mensaje)
    end
end
