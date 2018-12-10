class RecordpnyntsController < ApplicationController
  before_action :set_recordpnynt, only: [:show, :edit, :update, :destroy]

  # GET /recordpnynts
  # GET /recordpnynts.json
  def index
    @recordpnynts = Recordpnynt.all
  end

  # GET /recordpnynts/1
  # GET /recordpnynts/1.json
  def show
  end

  # GET /recordpnynts/new
  def new
    @recordpnynt = Recordpnynt.new
  end

  # GET /recordpnynts/1/edit
  def edit
  end

  # POST /recordpnynts
  # POST /recordpnynts.json
  def create
    @recordpnynt = Recordpnynt.new(recordpnynt_params)

    respond_to do |format|
      if @recordpnynt.save
        format.html { redirect_to @recordpnynt, notice: 'Recordpnynt was successfully created.' }
        format.json { render :show, status: :created, location: @recordpnynt }
      else
        format.html { render :new }
        format.json { render json: @recordpnynt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordpnynts/1
  # PATCH/PUT /recordpnynts/1.json
  def update
    respond_to do |format|
      if @recordpnynt.update(recordpnynt_params)
        format.html { redirect_to @recordpnynt, notice: 'Recordpnynt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordpnynt }
      else
        format.html { render :edit }
        format.json { render json: @recordpnynt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordpnynts/1
  # DELETE /recordpnynts/1.json
  def destroy
    @recordpnynt.destroy
    respond_to do |format|
      format.html { redirect_to recordpnynts_url, notice: 'Recordpnynt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordpnynt
      @recordpnynt = Recordpnynt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordpnynt_params
      params.require(:recordpnynt).permit(:ticket_id, :n1, :n2, :siglas, :monto)
    end
end
