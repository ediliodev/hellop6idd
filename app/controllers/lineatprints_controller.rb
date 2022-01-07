class LineatprintsController < ApplicationController
  before_action :set_lineatprint, only: [:show, :edit, :update, :destroy]

  # GET /lineatprints
  # GET /lineatprints.json
  def index
    #@lineatprints = Lineatprint.all
     @lineatprints = Lineat.all.today.sort_by { |a| + (a.pelea.to_i) } #no comprendo pero funciona el - por el + eviata el metodo .reverse ok. verificar luego. Sacado de link: https://stackoverflow.com/questions/6277127/sort-string-containing-numbers-in-ruby-rails
     @lineats = @lineatprints
  end

  # GET /lineatprints/1
  # GET /lineatprints/1.json
  def show
  end

  # GET /lineatprints/new
  def new
    @lineatprint = Lineatprint.new
  end

  # GET /lineatprints/1/edit
  def edit
  end

  # POST /lineatprints
  # POST /lineatprints.json
  def create
    @lineatprint = Lineatprint.new(lineatprint_params)

    respond_to do |format|
      if @lineatprint.save
        format.html { redirect_to @lineatprint, notice: 'Lineatprint was successfully created.' }
        format.json { render :show, status: :created, location: @lineatprint }
      else
        format.html { render :new }
        format.json { render json: @lineatprint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lineatprints/1
  # PATCH/PUT /lineatprints/1.json
  def update
    respond_to do |format|
      if @lineatprint.update(lineatprint_params)
        format.html { redirect_to @lineatprint, notice: 'Lineatprint was successfully updated.' }
        format.json { render :show, status: :ok, location: @lineatprint }
      else
        format.html { render :edit }
        format.json { render json: @lineatprint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lineatprints/1
  # DELETE /lineatprints/1.json
  def destroy
    @lineatprint.destroy
    respond_to do |format|
      format.html { redirect_to lineatprints_url, notice: 'Lineatprint was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lineatprint
      @lineatprint = Lineatprint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lineatprint_params
      params.require(:lineatprint).permit(:coliseo, :bloque, :pelea, :azul, :mla, :blanco, :mlb, :time, :under, :over, :status, :ganador, :tfinal)
    end
end
