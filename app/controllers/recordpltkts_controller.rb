class RecordpltktsController < ApplicationController
  before_action :set_recordpltkt, only: [:show, :edit, :update, :destroy]

  # GET /recordpltkts
  # GET /recordpltkts.json
  def index
    @recordpltkts = Recordpltkt.all
  end

  # GET /recordpltkts/1
  # GET /recordpltkts/1.json
  def show
  end

  # GET /recordpltkts/new
  def new
    @recordpltkt = Recordpltkt.new
  end

  # GET /recordpltkts/1/edit
  def edit
  end

  # POST /recordpltkts
  # POST /recordpltkts.json
  def create
    @recordpltkt = Recordpltkt.new(recordpltkt_params)

    respond_to do |format|
      if @recordpltkt.save
        format.html { redirect_to @recordpltkt, notice: 'Recordpltkt was successfully created.' }
        format.json { render :show, status: :created, location: @recordpltkt }
      else
        format.html { render :new }
        format.json { render json: @recordpltkt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordpltkts/1
  # PATCH/PUT /recordpltkts/1.json
  def update
    respond_to do |format|
      if @recordpltkt.update(recordpltkt_params)
        format.html { redirect_to @recordpltkt, notice: 'Recordpltkt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordpltkt }
      else
        format.html { render :edit }
        format.json { render json: @recordpltkt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordpltkts/1
  # DELETE /recordpltkts/1.json
  def destroy
    @recordpltkt.destroy
    respond_to do |format|
      format.html { redirect_to recordpltkts_url, notice: 'Recordpltkt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordpltkt
      @recordpltkt = Recordpltkt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordpltkt_params
      params.require(:recordpltkt).permit(:ticket_id, :n1, :n2, :siglas, :monto)
    end
end
