class RecordspnntsController < ApplicationController
  before_action :set_recordspnnt, only: [:show, :edit, :update, :destroy]

  # GET /recordspnnts
  # GET /recordspnnts.json
  def index
    @recordspnnts = Recordspnnt.all
  end

  # GET /recordspnnts/1
  # GET /recordspnnts/1.json
  def show
  end

  # GET /recordspnnts/new
  def new
    @recordspnnt = Recordspnnt.new
  end

  # GET /recordspnnts/1/edit
  def edit
  end

  # POST /recordspnnts
  # POST /recordspnnts.json
  def create
    @recordspnnt = Recordspnnt.new(recordspnnt_params)

    respond_to do |format|
      if @recordspnnt.save
        format.html { redirect_to @recordspnnt, notice: 'Recordspnnt was successfully created.' }
        format.json { render :show, status: :created, location: @recordspnnt }
      else
        format.html { render :new }
        format.json { render json: @recordspnnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordspnnts/1
  # PATCH/PUT /recordspnnts/1.json
  def update
    respond_to do |format|
      if @recordspnnt.update(recordspnnt_params)
        format.html { redirect_to @recordspnnt, notice: 'Recordspnnt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordspnnt }
      else
        format.html { render :edit }
        format.json { render json: @recordspnnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordspnnts/1
  # DELETE /recordspnnts/1.json
  def destroy
    @recordspnnt.destroy
    respond_to do |format|
      format.html { redirect_to recordspnnts_url, notice: 'Recordspnnt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordspnnt
      @recordspnnt = Recordspnnt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordspnnt_params
      params.require(:recordspnnt).permit(:ticket_id, :n1, :n2, :siglas, :monto)
    end
end
