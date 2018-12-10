class RecordtnntsController < ApplicationController
  before_action :set_recordtnnt, only: [:show, :edit, :update, :destroy]

  # GET /recordtnnts
  # GET /recordtnnts.json
  def index
    @recordtnnts = Recordtnnt.all
  end

  # GET /recordtnnts/1
  # GET /recordtnnts/1.json
  def show
  end

  # GET /recordtnnts/new
  def new
    @recordtnnt = Recordtnnt.new
  end

  # GET /recordtnnts/1/edit
  def edit
  end

  # POST /recordtnnts
  # POST /recordtnnts.json
  def create
    @recordtnnt = Recordtnnt.new(recordtnnt_params)

    respond_to do |format|
      if @recordtnnt.save
        format.html { redirect_to @recordtnnt, notice: 'Recordtnnt was successfully created.' }
        format.json { render :show, status: :created, location: @recordtnnt }
      else
        format.html { render :new }
        format.json { render json: @recordtnnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordtnnts/1
  # PATCH/PUT /recordtnnts/1.json
  def update
    respond_to do |format|
      if @recordtnnt.update(recordtnnt_params)
        format.html { redirect_to @recordtnnt, notice: 'Recordtnnt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordtnnt }
      else
        format.html { render :edit }
        format.json { render json: @recordtnnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordtnnts/1
  # DELETE /recordtnnts/1.json
  def destroy
    @recordtnnt.destroy
    respond_to do |format|
      format.html { redirect_to recordtnnts_url, notice: 'Recordtnnt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordtnnt
      @recordtnnt = Recordtnnt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordtnnt_params
      params.require(:recordtnnt).permit(:ticket_id, :n1, :n2, :n3, :siglas, :monto)
    end
end
