class SociotsController < ApplicationController
  before_action :set_sociot, only: [:show, :edit, :update, :destroy]

  # GET /sociots
  # GET /sociots.json
  def index
    @sociots = Sociot.all
  end

  # GET /sociots/1
  # GET /sociots/1.json
  def show
  end

  # GET /sociots/new
  def new
    @sociot = Sociot.new
  end

  # GET /sociots/1/edit
  def edit
  end

  # POST /sociots
  # POST /sociots.json
  def create
    @sociot = Sociot.new(sociot_params)

    respond_to do |format|
      if @sociot.save
        format.html { redirect_to @sociot, notice: 'Sociot was successfully created.' }
        format.json { render :show, status: :created, location: @sociot }
      else
        format.html { render :new }
        format.json { render json: @sociot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sociots/1
  # PATCH/PUT /sociots/1.json
  def update
    respond_to do |format|
      if @sociot.update(sociot_params)
        format.html { redirect_to @sociot, notice: 'Sociot was successfully updated.' }
        format.json { render :show, status: :ok, location: @sociot }
      else
        format.html { render :edit }
        format.json { render json: @sociot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sociots/1
  # DELETE /sociots/1.json
  def destroy
    @sociot.destroy
    respond_to do |format|
      format.html { redirect_to sociots_url, notice: 'Sociot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sociot
      @sociot = Sociot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sociot_params
      params.require(:sociot).permit(:nombre, :apellido, :telefono)
    end
end
