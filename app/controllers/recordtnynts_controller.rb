class RecordtnyntsController < ApplicationController
  before_action :set_recordtnynt, only: [:show, :edit, :update, :destroy]

  # GET /recordtnynts
  # GET /recordtnynts.json
  def index
    @recordtnynts = Recordtnynt.all
  end

  # GET /recordtnynts/1
  # GET /recordtnynts/1.json
  def show
  end

  # GET /recordtnynts/new
  def new
    @recordtnynt = Recordtnynt.new
  end

  # GET /recordtnynts/1/edit
  def edit
  end

  # POST /recordtnynts
  # POST /recordtnynts.json
  def create
    @recordtnynt = Recordtnynt.new(recordtnynt_params)

    respond_to do |format|
      if @recordtnynt.save
        format.html { redirect_to @recordtnynt, notice: 'Recordtnynt was successfully created.' }
        format.json { render :show, status: :created, location: @recordtnynt }
      else
        format.html { render :new }
        format.json { render json: @recordtnynt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordtnynts/1
  # PATCH/PUT /recordtnynts/1.json
  def update
    respond_to do |format|
      if @recordtnynt.update(recordtnynt_params)
        format.html { redirect_to @recordtnynt, notice: 'Recordtnynt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordtnynt }
      else
        format.html { render :edit }
        format.json { render json: @recordtnynt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordtnynts/1
  # DELETE /recordtnynts/1.json
  def destroy
    @recordtnynt.destroy
    respond_to do |format|
      format.html { redirect_to recordtnynts_url, notice: 'Recordtnynt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordtnynt
      @recordtnynt = Recordtnynt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordtnynt_params
      params.require(:recordtnynt).permit(:ticket_id, :n1, :n2, :n3, :siglas, :monto, :seleccionada)
    end
end
