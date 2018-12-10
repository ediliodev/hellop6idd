class ColectortsController < ApplicationController
  before_action :set_colectort, only: [:show, :edit, :update, :destroy]

  # GET /colectorts
  # GET /colectorts.json
  def index
    @colectorts = Colectort.all
  end

  # GET /colectorts/1
  # GET /colectorts/1.json
  def show
  end

  # GET /colectorts/new
  def new
    @colectort = Colectort.new
  end

  # GET /colectorts/1/edit
  def edit
  end

  # POST /colectorts
  # POST /colectorts.json
  def create
    @colectort = Colectort.new(colectort_params)

    respond_to do |format|
      if @colectort.save
        format.html { redirect_to @colectort, notice: 'Colectort was successfully created.' }
        format.json { render :show, status: :created, location: @colectort }
      else
        format.html { render :new }
        format.json { render json: @colectort.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /colectorts/1
  # PATCH/PUT /colectorts/1.json
  def update
    respond_to do |format|
      if @colectort.update(colectort_params)
        format.html { redirect_to @colectort, notice: 'Colectort was successfully updated.' }
        format.json { render :show, status: :ok, location: @colectort }
      else
        format.html { render :edit }
        format.json { render json: @colectort.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colectorts/1
  # DELETE /colectorts/1.json
  def destroy
    @colectort.destroy
    respond_to do |format|
      format.html { redirect_to colectorts_url, notice: 'Colectort was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_colectort
      @colectort = Colectort.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def colectort_params
      params.require(:colectort).permit(:nombre, :apellido, :cedula, :telefono)
    end
end
