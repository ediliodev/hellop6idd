class RecordspltknntsController < ApplicationController
  before_action :set_recordspltknnt, only: [:show, :edit, :update, :destroy]

  # GET /recordspltknnts
  # GET /recordspltknnts.json
  def index
    @recordspltknnts = Recordspltknnt.all
  end

  # GET /recordspltknnts/1
  # GET /recordspltknnts/1.json
  def show
  end

  # GET /recordspltknnts/new
  def new
    @recordspltknnt = Recordspltknnt.new
  end

  # GET /recordspltknnts/1/edit
  def edit
  end

  # POST /recordspltknnts
  # POST /recordspltknnts.json
  def create
    @recordspltknnt = Recordspltknnt.new(recordspltknnt_params)

    respond_to do |format|
      if @recordspltknnt.save
        format.html { redirect_to @recordspltknnt, notice: 'Recordspltknnt was successfully created.' }
        format.json { render :show, status: :created, location: @recordspltknnt }
      else
        format.html { render :new }
        format.json { render json: @recordspltknnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordspltknnts/1
  # PATCH/PUT /recordspltknnts/1.json
  def update
    respond_to do |format|
      if @recordspltknnt.update(recordspltknnt_params)
        format.html { redirect_to @recordspltknnt, notice: 'Recordspltknnt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordspltknnt }
      else
        format.html { render :edit }
        format.json { render json: @recordspltknnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordspltknnts/1
  # DELETE /recordspltknnts/1.json
  def destroy
    @recordspltknnt.destroy
    respond_to do |format|
      format.html { redirect_to recordspltknnts_url, notice: 'Recordspltknnt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordspltknnt
      @recordspltknnt = Recordspltknnt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordspltknnt_params
      params.require(:recordspltknnt).permit(:ticket_id, :n1, :n2, :siglas, :monto)
    end
end
