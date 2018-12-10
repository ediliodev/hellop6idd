class RecordqnntsController < ApplicationController
  before_action :set_recordqnnt, only: [:show, :edit, :update, :destroy]

  # GET /recordqnnts
  # GET /recordqnnts.json
  def index
    @recordqnnts = Recordqnnt.all
  end

  # GET /recordqnnts/1
  # GET /recordqnnts/1.json
  def show
  end

  # GET /recordqnnts/new
  def new
    @recordqnnt = Recordqnnt.new
  end

  # GET /recordqnnts/1/edit
  def edit
  end

  # POST /recordqnnts
  # POST /recordqnnts.json
  def create
    @recordqnnt = Recordqnnt.new(recordqnnt_params)

    respond_to do |format|
      if @recordqnnt.save
        format.html { redirect_to @recordqnnt, notice: 'Recordqnnt was successfully created.' }
        format.json { render :show, status: :created, location: @recordqnnt }
      else
        format.html { render :new }
        format.json { render json: @recordqnnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordqnnts/1
  # PATCH/PUT /recordqnnts/1.json
  def update
    respond_to do |format|
      if @recordqnnt.update(recordqnnt_params)
        format.html { redirect_to @recordqnnt, notice: 'Recordqnnt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordqnnt }
      else
        format.html { render :edit }
        format.json { render json: @recordqnnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordqnnts/1
  # DELETE /recordqnnts/1.json
  def destroy
    @recordqnnt.destroy
    respond_to do |format|
      format.html { redirect_to recordqnnts_url, notice: 'Recordqnnt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordqnnt
      @recordqnnt = Recordqnnt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordqnnt_params
      params.require(:recordqnnt).permit(:ticket_id, :n1, :monto)
    end
end
