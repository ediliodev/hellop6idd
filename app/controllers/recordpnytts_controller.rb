class RecordpnyttsController < ApplicationController
  before_action :set_recordpnytt, only: [:show, :edit, :update, :destroy]

  # GET /recordpnytts
  # GET /recordpnytts.json
  def index
    @recordpnytts = Recordpnytt.all
  end

  # GET /recordpnytts/1
  # GET /recordpnytts/1.json
  def show
  end

  # GET /recordpnytts/new
  def new
    @recordpnytt = Recordpnytt.new
  end

  # GET /recordpnytts/1/edit
  def edit
  end

  # POST /recordpnytts
  # POST /recordpnytts.json
  def create
    @recordpnytt = Recordpnytt.new(recordpnytt_params)

    respond_to do |format|
      if @recordpnytt.save
        format.html { redirect_to @recordpnytt, notice: 'Recordpnytt was successfully created.' }
        format.json { render :show, status: :created, location: @recordpnytt }
      else
        format.html { render :new }
        format.json { render json: @recordpnytt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordpnytts/1
  # PATCH/PUT /recordpnytts/1.json
  def update
    respond_to do |format|
      if @recordpnytt.update(recordpnytt_params)
        format.html { redirect_to @recordpnytt, notice: 'Recordpnytt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordpnytt }
      else
        format.html { render :edit }
        format.json { render json: @recordpnytt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordpnytts/1
  # DELETE /recordpnytts/1.json
  def destroy
    @recordpnytt.destroy
    respond_to do |format|
      format.html { redirect_to recordpnytts_url, notice: 'Recordpnytt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordpnytt
      @recordpnytt = Recordpnytt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordpnytt_params
      params.require(:recordpnytt).permit(:ticket_id, :n1, :n2, :siglas, :monto)
    end
end
