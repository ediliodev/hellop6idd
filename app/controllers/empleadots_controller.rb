class EmpleadotsController < ApplicationController
  before_action :set_empleadot, only: [:show, :edit, :update, :destroy]

  # GET /empleadots
  # GET /empleadots.json
  def index
    @empleadots = Empleadot.all
  end

  # GET /empleadots/1
  # GET /empleadots/1.json
  def show
  end

  # GET /empleadots/new
  def new
    @empleadot = Empleadot.new
  end

  # GET /empleadots/1/edit
  def edit
  end

  # POST /empleadots
  # POST /empleadots.json
  def create
    @empleadot = Empleadot.new(empleadot_params)

    respond_to do |format|
      if @empleadot.save
        format.html { redirect_to @empleadot, notice: 'Empleadot was successfully created.' }
        format.json { render :show, status: :created, location: @empleadot }
      else
        format.html { render :new }
        format.json { render json: @empleadot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empleadots/1
  # PATCH/PUT /empleadots/1.json
  def update
    respond_to do |format|
      if @empleadot.update(empleadot_params)
        format.html { redirect_to @empleadot, notice: 'Empleadot was successfully updated.' }
        format.json { render :show, status: :ok, location: @empleadot }
      else
        format.html { render :edit }
        format.json { render json: @empleadot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /empleadots/1
  # DELETE /empleadots/1.json
  def destroy
    @empleadot.destroy
    respond_to do |format|
      format.html { redirect_to empleadots_url, notice: 'Empleadot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_empleadot
      @empleadot = Empleadot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empleadot_params
      params.require(:empleadot).permit(:nombre, :apellido, :cedula, :telefono)
    end
end
