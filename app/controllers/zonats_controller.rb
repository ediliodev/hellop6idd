class ZonatsController < ApplicationController
  before_action :set_zonat, only: [:show, :edit, :update, :destroy]

  # GET /zonats
  # GET /zonats.json
  def index
    @zonats = Zonat.all
  end

  # GET /zonats/1
  # GET /zonats/1.json
  def show
  end

  # GET /zonats/new
  def new
    @zonat = Zonat.new
  end

  # GET /zonats/1/edit
  def edit
  end

  # POST /zonats
  # POST /zonats.json
  def create
    @zonat = Zonat.new(zonat_params)

    respond_to do |format|
      if @zonat.save
        format.html { redirect_to @zonat, notice: 'Zonat was successfully created.' }
        format.json { render :show, status: :created, location: @zonat }
      else
        format.html { render :new }
        format.json { render json: @zonat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /zonats/1
  # PATCH/PUT /zonats/1.json
  def update
    respond_to do |format|
      if @zonat.update(zonat_params)
        format.html { redirect_to @zonat, notice: 'Zonat was successfully updated.' }
        format.json { render :show, status: :ok, location: @zonat }
      else
        format.html { render :edit }
        format.json { render json: @zonat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zonats/1
  # DELETE /zonats/1.json
  def destroy
    @zonat.destroy
    respond_to do |format|
      format.html { redirect_to zonats_url, notice: 'Zonat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zonat
      @zonat = Zonat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def zonat_params
      params.require(:zonat).permit(:nombre, :descripcion)
    end
end
