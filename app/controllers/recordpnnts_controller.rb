class RecordpnntsController < ApplicationController
  before_action :set_recordpnnt, only: [:show, :edit, :update, :destroy]

  # GET /recordpnnts
  # GET /recordpnnts.json
  def index
    @recordpnnts = Recordpnnt.all
  end

  # GET /recordpnnts/1
  # GET /recordpnnts/1.json
  def show
  end

  # GET /recordpnnts/new
  def new
    @recordpnnt = Recordpnnt.new
  end

  # GET /recordpnnts/1/edit
  def edit
  end

  # POST /recordpnnts
  # POST /recordpnnts.json
  def create
    @recordpnnt = Recordpnnt.new(recordpnnt_params)

    respond_to do |format|
      if @recordpnnt.save
        format.html { redirect_to @recordpnnt, notice: 'Recordpnnt was successfully created.' }
        format.json { render :show, status: :created, location: @recordpnnt }
      else
        format.html { render :new }
        format.json { render json: @recordpnnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordpnnts/1
  # PATCH/PUT /recordpnnts/1.json
  def update
    respond_to do |format|
      if @recordpnnt.update(recordpnnt_params)
        format.html { redirect_to @recordpnnt, notice: 'Recordpnnt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordpnnt }
      else
        format.html { render :edit }
        format.json { render json: @recordpnnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordpnnts/1
  # DELETE /recordpnnts/1.json
  def destroy
    @recordpnnt.destroy
    respond_to do |format|
      format.html { redirect_to recordpnnts_url, notice: 'Recordpnnt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordpnnt
      @recordpnnt = Recordpnnt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordpnnt_params
      params.require(:recordpnnt).permit(:ticket_id, :n1, :n2, :siglas, :monto)
    end
end
