class RecordspleinntsController < ApplicationController
  before_action :set_recordspleinnt, only: [:show, :edit, :update, :destroy]

  # GET /recordspleinnts
  # GET /recordspleinnts.json
  def index
    @recordspleinnts = Recordspleinnt.all
  end

  # GET /recordspleinnts/1
  # GET /recordspleinnts/1.json
  def show
  end

  # GET /recordspleinnts/new
  def new
    @recordspleinnt = Recordspleinnt.new
  end

  # GET /recordspleinnts/1/edit
  def edit
  end

  # POST /recordspleinnts
  # POST /recordspleinnts.json
  def create
    @recordspleinnt = Recordspleinnt.new(recordspleinnt_params)

    respond_to do |format|
      if @recordspleinnt.save
        format.html { redirect_to @recordspleinnt, notice: 'Recordspleinnt was successfully created.' }
        format.json { render :show, status: :created, location: @recordspleinnt }
      else
        format.html { render :new }
        format.json { render json: @recordspleinnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordspleinnts/1
  # PATCH/PUT /recordspleinnts/1.json
  def update
    respond_to do |format|
      if @recordspleinnt.update(recordspleinnt_params)
        format.html { redirect_to @recordspleinnt, notice: 'Recordspleinnt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordspleinnt }
      else
        format.html { render :edit }
        format.json { render json: @recordspleinnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordspleinnts/1
  # DELETE /recordspleinnts/1.json
  def destroy
    @recordspleinnt.destroy
    respond_to do |format|
      format.html { redirect_to recordspleinnts_url, notice: 'Recordspleinnt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordspleinnt
      @recordspleinnt = Recordspleinnt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordspleinnt_params
      params.require(:recordspleinnt).permit(:ticket_id, :n1, :n2, :siglas, :monto)
    end
end
