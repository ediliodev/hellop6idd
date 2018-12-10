class HorariosorteotsController < ApplicationController
  before_action :set_horariosorteot, only: [:show, :edit, :update, :destroy]

  # GET /horariosorteots
  # GET /horariosorteots.json
  def index
    @horariosorteots = Horariosorteot.all
  end

  # GET /horariosorteots/1
  # GET /horariosorteots/1.json
  def show
  end

  # GET /horariosorteots/new
  def new
    @horariosorteot = Horariosorteot.new
  end

  # GET /horariosorteots/1/edit
  def edit
  end

  # POST /horariosorteots
  # POST /horariosorteots.json
  def create
    @horariosorteot = Horariosorteot.new(horariosorteot_params)

    respond_to do |format|
      if @horariosorteot.save
        format.html { redirect_to @horariosorteot, notice: 'Horariosorteot was successfully created.' }
        format.json { render :show, status: :created, location: @horariosorteot }
      else
        format.html { render :new }
        format.json { render json: @horariosorteot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /horariosorteots/1
  # PATCH/PUT /horariosorteots/1.json
  def update
    respond_to do |format|
      if @horariosorteot.update(horariosorteot_params)
        format.html { redirect_to @horariosorteot, notice: 'Horariosorteot was successfully updated.' }
        format.json { render :show, status: :ok, location: @horariosorteot }
      else
        format.html { render :edit }
        format.json { render json: @horariosorteot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /horariosorteots/1
  # DELETE /horariosorteots/1.json
  def destroy
    @horariosorteot.destroy
    respond_to do |format|
      format.html { redirect_to horariosorteots_url, notice: 'Horariosorteot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_horariosorteot
      @horariosorteot = Horariosorteot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def horariosorteot_params
      params.require(:horariosorteot).permit(:nombre, :lunes, :martes, :miercoles, :jueves, :viernes, :sabado, :domingo)
    end
end
