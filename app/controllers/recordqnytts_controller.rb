class RecordqnyttsController < ApplicationController
  before_action :set_recordqnytt, only: [:show, :edit, :update, :destroy]

  # GET /recordqnytts
  # GET /recordqnytts.json
  def index
    @recordqnytts = Recordqnytt.all
  end

  # GET /recordqnytts/1
  # GET /recordqnytts/1.json
  def show
  end

  # GET /recordqnytts/new
  def new
    @recordqnytt = Recordqnytt.new
  end

  # GET /recordqnytts/1/edit
  def edit
  end

  # POST /recordqnytts
  # POST /recordqnytts.json
  def create
    @recordqnytt = Recordqnytt.new(recordqnytt_params)

    respond_to do |format|
      if @recordqnytt.save
        format.html { redirect_to @recordqnytt, notice: 'Recordqnytt was successfully created.' }
        format.json { render :show, status: :created, location: @recordqnytt }
      else
        format.html { render :new }
        format.json { render json: @recordqnytt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordqnytts/1
  # PATCH/PUT /recordqnytts/1.json
  def update
    respond_to do |format|
      if @recordqnytt.update(recordqnytt_params)
        format.html { redirect_to @recordqnytt, notice: 'Recordqnytt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordqnytt }
      else
        format.html { render :edit }
        format.json { render json: @recordqnytt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordqnytts/1
  # DELETE /recordqnytts/1.json
  def destroy
    @recordqnytt.destroy
    respond_to do |format|
      format.html { redirect_to recordqnytts_url, notice: 'Recordqnytt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordqnytt
      @recordqnytt = Recordqnytt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordqnytt_params
      params.require(:recordqnytt).permit(:ticket_id, :n1, :monto)
    end
end
