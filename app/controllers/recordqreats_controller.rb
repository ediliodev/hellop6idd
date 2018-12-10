class RecordqreatsController < ApplicationController
  before_action :set_recordqreat, only: [:show, :edit, :update, :destroy]

  # GET /recordqreats
  # GET /recordqreats.json
  def index
    @recordqreats = Recordqreat.all
  end

  # GET /recordqreats/1
  # GET /recordqreats/1.json
  def show
  end

  # GET /recordqreats/new
  def new
    @recordqreat = Recordqreat.new
  end

  # GET /recordqreats/1/edit
  def edit
  end

  # POST /recordqreats
  # POST /recordqreats.json
  def create
    @recordqreat = Recordqreat.new(recordqreat_params)

    respond_to do |format|
      if @recordqreat.save
        format.html { redirect_to @recordqreat, notice: 'Recordqreat was successfully created.' }
        format.json { render :show, status: :created, location: @recordqreat }
      else
        format.html { render :new }
        format.json { render json: @recordqreat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordqreats/1
  # PATCH/PUT /recordqreats/1.json
  def update
    respond_to do |format|
      if @recordqreat.update(recordqreat_params)
        format.html { redirect_to @recordqreat, notice: 'Recordqreat was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordqreat }
      else
        format.html { render :edit }
        format.json { render json: @recordqreat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordqreats/1
  # DELETE /recordqreats/1.json
  def destroy
    @recordqreat.destroy
    respond_to do |format|
      format.html { redirect_to recordqreats_url, notice: 'Recordqreat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordqreat
      @recordqreat = Recordqreat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordqreat_params
      params.require(:recordqreat).permit(:ticket_id, :n1, :monto)
    end
end
