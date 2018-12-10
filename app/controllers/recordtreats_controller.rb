class RecordtreatsController < ApplicationController
  before_action :set_recordtreat, only: [:show, :edit, :update, :destroy]

  # GET /recordtreats
  # GET /recordtreats.json
  def index
    @recordtreats = Recordtreat.all
  end

  # GET /recordtreats/1
  # GET /recordtreats/1.json
  def show
  end

  # GET /recordtreats/new
  def new
    @recordtreat = Recordtreat.new
  end

  # GET /recordtreats/1/edit
  def edit
  end

  # POST /recordtreats
  # POST /recordtreats.json
  def create
    @recordtreat = Recordtreat.new(recordtreat_params)

    respond_to do |format|
      if @recordtreat.save
        format.html { redirect_to @recordtreat, notice: 'Recordtreat was successfully created.' }
        format.json { render :show, status: :created, location: @recordtreat }
      else
        format.html { render :new }
        format.json { render json: @recordtreat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordtreats/1
  # PATCH/PUT /recordtreats/1.json
  def update
    respond_to do |format|
      if @recordtreat.update(recordtreat_params)
        format.html { redirect_to @recordtreat, notice: 'Recordtreat was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordtreat }
      else
        format.html { render :edit }
        format.json { render json: @recordtreat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordtreats/1
  # DELETE /recordtreats/1.json
  def destroy
    @recordtreat.destroy
    respond_to do |format|
      format.html { redirect_to recordtreats_url, notice: 'Recordtreat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordtreat
      @recordtreat = Recordtreat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordtreat_params
      params.require(:recordtreat).permit(:ticket_id, :n1, :n2, :n3, :siglas, :monto, :seleccionada)
    end
end
