class RecordtnyttsController < ApplicationController
  before_action :set_recordtnytt, only: [:show, :edit, :update, :destroy]

  # GET /recordtnytts
  # GET /recordtnytts.json
  def index
    @recordtnytts = Recordtnytt.all
  end

  # GET /recordtnytts/1
  # GET /recordtnytts/1.json
  def show
  end

  # GET /recordtnytts/new
  def new
    @recordtnytt = Recordtnytt.new
  end

  # GET /recordtnytts/1/edit
  def edit
  end

  # POST /recordtnytts
  # POST /recordtnytts.json
  def create
    @recordtnytt = Recordtnytt.new(recordtnytt_params)

    respond_to do |format|
      if @recordtnytt.save
        format.html { redirect_to @recordtnytt, notice: 'Recordtnytt was successfully created.' }
        format.json { render :show, status: :created, location: @recordtnytt }
      else
        format.html { render :new }
        format.json { render json: @recordtnytt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordtnytts/1
  # PATCH/PUT /recordtnytts/1.json
  def update
    respond_to do |format|
      if @recordtnytt.update(recordtnytt_params)
        format.html { redirect_to @recordtnytt, notice: 'Recordtnytt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordtnytt }
      else
        format.html { render :edit }
        format.json { render json: @recordtnytt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordtnytts/1
  # DELETE /recordtnytts/1.json
  def destroy
    @recordtnytt.destroy
    respond_to do |format|
      format.html { redirect_to recordtnytts_url, notice: 'Recordtnytt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordtnytt
      @recordtnytt = Recordtnytt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordtnytt_params
      params.require(:recordtnytt).permit(:ticket_id, :n1, :n2, :n3, :siglas, :monto, :seleccionada)
    end
end
