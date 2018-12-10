class RecordtgmtsController < ApplicationController
  before_action :set_recordtgmt, only: [:show, :edit, :update, :destroy]

  # GET /recordtgmts
  # GET /recordtgmts.json
  def index
    @recordtgmts = Recordtgmt.all
  end

  # GET /recordtgmts/1
  # GET /recordtgmts/1.json
  def show
  end

  # GET /recordtgmts/new
  def new
    @recordtgmt = Recordtgmt.new
  end

  # GET /recordtgmts/1/edit
  def edit
  end

  # POST /recordtgmts
  # POST /recordtgmts.json
  def create
    @recordtgmt = Recordtgmt.new(recordtgmt_params)

    respond_to do |format|
      if @recordtgmt.save
        format.html { redirect_to @recordtgmt, notice: 'Recordtgmt was successfully created.' }
        format.json { render :show, status: :created, location: @recordtgmt }
      else
        format.html { render :new }
        format.json { render json: @recordtgmt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordtgmts/1
  # PATCH/PUT /recordtgmts/1.json
  def update
    respond_to do |format|
      if @recordtgmt.update(recordtgmt_params)
        format.html { redirect_to @recordtgmt, notice: 'Recordtgmt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordtgmt }
      else
        format.html { render :edit }
        format.json { render json: @recordtgmt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordtgmts/1
  # DELETE /recordtgmts/1.json
  def destroy
    @recordtgmt.destroy
    respond_to do |format|
      format.html { redirect_to recordtgmts_url, notice: 'Recordtgmt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordtgmt
      @recordtgmt = Recordtgmt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordtgmt_params
      params.require(:recordtgmt).permit(:ticket_id, :n1, :n2, :n3, :siglas, :monto, :seleccionada)
    end
end
