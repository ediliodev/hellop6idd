class RecordqleitsController < ApplicationController
  before_action :set_recordqleit, only: [:show, :edit, :update, :destroy]

  # GET /recordqleits
  # GET /recordqleits.json
  def index
    @recordqleits = Recordqleit.all
  end

  # GET /recordqleits/1
  # GET /recordqleits/1.json
  def show
  end

  # GET /recordqleits/new
  def new
    @recordqleit = Recordqleit.new
  end

  # GET /recordqleits/1/edit
  def edit
  end

  # POST /recordqleits
  # POST /recordqleits.json
  def create
    @recordqleit = Recordqleit.new(recordqleit_params)

    respond_to do |format|
      if @recordqleit.save
        format.html { redirect_to @recordqleit, notice: 'Recordqleit was successfully created.' }
        format.json { render :show, status: :created, location: @recordqleit }
      else
        format.html { render :new }
        format.json { render json: @recordqleit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordqleits/1
  # PATCH/PUT /recordqleits/1.json
  def update
    respond_to do |format|
      if @recordqleit.update(recordqleit_params)
        format.html { redirect_to @recordqleit, notice: 'Recordqleit was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordqleit }
      else
        format.html { render :edit }
        format.json { render json: @recordqleit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordqleits/1
  # DELETE /recordqleits/1.json
  def destroy
    @recordqleit.destroy
    respond_to do |format|
      format.html { redirect_to recordqleits_url, notice: 'Recordqleit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordqleit
      @recordqleit = Recordqleit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordqleit_params
      params.require(:recordqleit).permit(:ticket_id, :n1, :monto)
    end
end
