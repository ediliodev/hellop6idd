class RecordqnyntsController < ApplicationController
  before_action :set_recordqnynt, only: [:show, :edit, :update, :destroy]

  # GET /recordqnynts
  # GET /recordqnynts.json
  def index
    @recordqnynts = Recordqnynt.all
  end

  # GET /recordqnynts/1
  # GET /recordqnynts/1.json
  def show
  end

  # GET /recordqnynts/new
  def new
    @recordqnynt = Recordqnynt.new
  end

  # GET /recordqnynts/1/edit
  def edit
  end

  # POST /recordqnynts
  # POST /recordqnynts.json
  def create
    @recordqnynt = Recordqnynt.new(recordqnynt_params)

    respond_to do |format|
      if @recordqnynt.save
        format.html { redirect_to @recordqnynt, notice: 'Recordqnynt was successfully created.' }
        format.json { render :show, status: :created, location: @recordqnynt }
      else
        format.html { render :new }
        format.json { render json: @recordqnynt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordqnynts/1
  # PATCH/PUT /recordqnynts/1.json
  def update
    respond_to do |format|
      if @recordqnynt.update(recordqnynt_params)
        format.html { redirect_to @recordqnynt, notice: 'Recordqnynt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordqnynt }
      else
        format.html { render :edit }
        format.json { render json: @recordqnynt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordqnynts/1
  # DELETE /recordqnynts/1.json
  def destroy
    @recordqnynt.destroy
    respond_to do |format|
      format.html { redirect_to recordqnynts_url, notice: 'Recordqnynt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordqnynt
      @recordqnynt = Recordqnynt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordqnynt_params
      params.require(:recordqnynt).permit(:ticket_id, :n1, :monto)
    end
end
