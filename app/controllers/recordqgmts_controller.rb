class RecordqgmtsController < ApplicationController
  before_action :set_recordqgmt, only: [:show, :edit, :update, :destroy]

  # GET /recordqgmts
  # GET /recordqgmts.json
  def index
    @recordqgmts = Recordqgmt.all
  end

  # GET /recordqgmts/1
  # GET /recordqgmts/1.json
  def show
  end

  # GET /recordqgmts/new
  def new
    @recordqgmt = Recordqgmt.new
  end

  # GET /recordqgmts/1/edit
  def edit
  end

  # POST /recordqgmts
  # POST /recordqgmts.json
  def create
    @recordqgmt = Recordqgmt.new(recordqgmt_params)

    respond_to do |format|
      if @recordqgmt.save
        format.html { redirect_to @recordqgmt, notice: 'Recordqgmt was successfully created.' }
        format.json { render :show, status: :created, location: @recordqgmt }
      else
        format.html { render :new }
        format.json { render json: @recordqgmt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordqgmts/1
  # PATCH/PUT /recordqgmts/1.json
  def update
    respond_to do |format|
      if @recordqgmt.update(recordqgmt_params)
        format.html { redirect_to @recordqgmt, notice: 'Recordqgmt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordqgmt }
      else
        format.html { render :edit }
        format.json { render json: @recordqgmt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordqgmts/1
  # DELETE /recordqgmts/1.json
  def destroy
    @recordqgmt.destroy
    respond_to do |format|
      format.html { redirect_to recordqgmts_url, notice: 'Recordqgmt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordqgmt
      @recordqgmt = Recordqgmt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordqgmt_params
      params.require(:recordqgmt).permit(:ticket_id, :n1, :monto)
    end
end
