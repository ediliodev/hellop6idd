class RecordtleitsController < ApplicationController
  before_action :set_recordtleit, only: [:show, :edit, :update, :destroy]

  # GET /recordtleits
  # GET /recordtleits.json
  def index
    @recordtleits = Recordtleit.all
  end

  # GET /recordtleits/1
  # GET /recordtleits/1.json
  def show
  end

  # GET /recordtleits/new
  def new
    @recordtleit = Recordtleit.new
  end

  # GET /recordtleits/1/edit
  def edit
  end

  # POST /recordtleits
  # POST /recordtleits.json
  def create
    @recordtleit = Recordtleit.new(recordtleit_params)

    respond_to do |format|
      if @recordtleit.save
        format.html { redirect_to @recordtleit, notice: 'Recordtleit was successfully created.' }
        format.json { render :show, status: :created, location: @recordtleit }
      else
        format.html { render :new }
        format.json { render json: @recordtleit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordtleits/1
  # PATCH/PUT /recordtleits/1.json
  def update
    respond_to do |format|
      if @recordtleit.update(recordtleit_params)
        format.html { redirect_to @recordtleit, notice: 'Recordtleit was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordtleit }
      else
        format.html { render :edit }
        format.json { render json: @recordtleit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordtleits/1
  # DELETE /recordtleits/1.json
  def destroy
    @recordtleit.destroy
    respond_to do |format|
      format.html { redirect_to recordtleits_url, notice: 'Recordtleit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordtleit
      @recordtleit = Recordtleit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordtleit_params
      params.require(:recordtleit).permit(:ticket_id, :n1, :n2, :n3, :siglas, :monto, :seleccionada)
    end
end
