class RecordpgmtsController < ApplicationController
  before_action :set_recordpgmt, only: [:show, :edit, :update, :destroy]

  # GET /recordpgmts
  # GET /recordpgmts.json
  def index
    @recordpgmts = Recordpgmt.all
  end

  # GET /recordpgmts/1
  # GET /recordpgmts/1.json
  def show
  end

  # GET /recordpgmts/new
  def new
    @recordpgmt = Recordpgmt.new
  end

  # GET /recordpgmts/1/edit
  def edit
  end

  # POST /recordpgmts
  # POST /recordpgmts.json
  def create
    @recordpgmt = Recordpgmt.new(recordpgmt_params)

    respond_to do |format|
      if @recordpgmt.save
        format.html { redirect_to @recordpgmt, notice: 'Recordpgmt was successfully created.' }
        format.json { render :show, status: :created, location: @recordpgmt }
      else
        format.html { render :new }
        format.json { render json: @recordpgmt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordpgmts/1
  # PATCH/PUT /recordpgmts/1.json
  def update
    respond_to do |format|
      if @recordpgmt.update(recordpgmt_params)
        format.html { redirect_to @recordpgmt, notice: 'Recordpgmt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordpgmt }
      else
        format.html { render :edit }
        format.json { render json: @recordpgmt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordpgmts/1
  # DELETE /recordpgmts/1.json
  def destroy
    @recordpgmt.destroy
    respond_to do |format|
      format.html { redirect_to recordpgmts_url, notice: 'Recordpgmt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordpgmt
      @recordpgmt = Recordpgmt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordpgmt_params
      params.require(:recordpgmt).permit(:ticket_id, :n1, :n2, :siglas, :monto)
    end
end
