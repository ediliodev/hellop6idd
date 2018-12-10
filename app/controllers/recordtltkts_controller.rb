class RecordtltktsController < ApplicationController
  before_action :set_recordtltkt, only: [:show, :edit, :update, :destroy]

  # GET /recordtltkts
  # GET /recordtltkts.json
  def index
    @recordtltkts = Recordtltkt.all
  end

  # GET /recordtltkts/1
  # GET /recordtltkts/1.json
  def show
  end

  # GET /recordtltkts/new
  def new
    @recordtltkt = Recordtltkt.new
  end

  # GET /recordtltkts/1/edit
  def edit
  end

  # POST /recordtltkts
  # POST /recordtltkts.json
  def create
    @recordtltkt = Recordtltkt.new(recordtltkt_params)

    respond_to do |format|
      if @recordtltkt.save
        format.html { redirect_to @recordtltkt, notice: 'Recordtltkt was successfully created.' }
        format.json { render :show, status: :created, location: @recordtltkt }
      else
        format.html { render :new }
        format.json { render json: @recordtltkt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordtltkts/1
  # PATCH/PUT /recordtltkts/1.json
  def update
    respond_to do |format|
      if @recordtltkt.update(recordtltkt_params)
        format.html { redirect_to @recordtltkt, notice: 'Recordtltkt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordtltkt }
      else
        format.html { render :edit }
        format.json { render json: @recordtltkt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordtltkts/1
  # DELETE /recordtltkts/1.json
  def destroy
    @recordtltkt.destroy
    respond_to do |format|
      format.html { redirect_to recordtltkts_url, notice: 'Recordtltkt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordtltkt
      @recordtltkt = Recordtltkt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordtltkt_params
      params.require(:recordtltkt).permit(:ticket_id, :n1, :n2, :n3, :siglas, :monto, :seleccionada)
    end
end
