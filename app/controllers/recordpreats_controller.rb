class RecordpreatsController < ApplicationController
  before_action :set_recordpreat, only: [:show, :edit, :update, :destroy]

  # GET /recordpreats
  # GET /recordpreats.json
  def index
    @recordpreats = Recordpreat.all
  end

  # GET /recordpreats/1
  # GET /recordpreats/1.json
  def show
  end

  # GET /recordpreats/new
  def new
    @recordpreat = Recordpreat.new
  end

  # GET /recordpreats/1/edit
  def edit
  end

  # POST /recordpreats
  # POST /recordpreats.json
  def create
    @recordpreat = Recordpreat.new(recordpreat_params)

    respond_to do |format|
      if @recordpreat.save
        format.html { redirect_to @recordpreat, notice: 'Recordpreat was successfully created.' }
        format.json { render :show, status: :created, location: @recordpreat }
      else
        format.html { render :new }
        format.json { render json: @recordpreat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordpreats/1
  # PATCH/PUT /recordpreats/1.json
  def update
    respond_to do |format|
      if @recordpreat.update(recordpreat_params)
        format.html { redirect_to @recordpreat, notice: 'Recordpreat was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordpreat }
      else
        format.html { render :edit }
        format.json { render json: @recordpreat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordpreats/1
  # DELETE /recordpreats/1.json
  def destroy
    @recordpreat.destroy
    respond_to do |format|
      format.html { redirect_to recordpreats_url, notice: 'Recordpreat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordpreat
      @recordpreat = Recordpreat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordpreat_params
      params.require(:recordpreat).permit(:ticket_id, :n1, :n2, :siglas, :monto)
    end
end
