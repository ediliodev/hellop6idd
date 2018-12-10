class RecordqltktsController < ApplicationController
  before_action :set_recordqltkt, only: [:show, :edit, :update, :destroy]

  # GET /recordqltkts
  # GET /recordqltkts.json
  def index
    @recordqltkts = Recordqltkt.all
  end

  # GET /recordqltkts/1
  # GET /recordqltkts/1.json
  def show
  end

  # GET /recordqltkts/new
  def new
    @recordqltkt = Recordqltkt.new
  end

  # GET /recordqltkts/1/edit
  def edit
  end

  # POST /recordqltkts
  # POST /recordqltkts.json
  def create
    @recordqltkt = Recordqltkt.new(recordqltkt_params)

    respond_to do |format|
      if @recordqltkt.save
        format.html { redirect_to @recordqltkt, notice: 'Recordqltkt was successfully created.' }
        format.json { render :show, status: :created, location: @recordqltkt }
      else
        format.html { render :new }
        format.json { render json: @recordqltkt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordqltkts/1
  # PATCH/PUT /recordqltkts/1.json
  def update
    respond_to do |format|
      if @recordqltkt.update(recordqltkt_params)
        format.html { redirect_to @recordqltkt, notice: 'Recordqltkt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordqltkt }
      else
        format.html { render :edit }
        format.json { render json: @recordqltkt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordqltkts/1
  # DELETE /recordqltkts/1.json
  def destroy
    @recordqltkt.destroy
    respond_to do |format|
      format.html { redirect_to recordqltkts_url, notice: 'Recordqltkt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordqltkt
      @recordqltkt = Recordqltkt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordqltkt_params
      params.require(:recordqltkt).permit(:ticket_id, :n1, :monto)
    end
end
