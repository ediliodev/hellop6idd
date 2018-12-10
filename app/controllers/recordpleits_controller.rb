class RecordpleitsController < ApplicationController
  before_action :set_recordpleit, only: [:show, :edit, :update, :destroy]

  # GET /recordpleits
  # GET /recordpleits.json
  def index
    @recordpleits = Recordpleit.all
  end

  # GET /recordpleits/1
  # GET /recordpleits/1.json
  def show
  end

  # GET /recordpleits/new
  def new
    @recordpleit = Recordpleit.new
  end

  # GET /recordpleits/1/edit
  def edit
  end

  # POST /recordpleits
  # POST /recordpleits.json
  def create
    @recordpleit = Recordpleit.new(recordpleit_params)

    respond_to do |format|
      if @recordpleit.save
        format.html { redirect_to @recordpleit, notice: 'Recordpleit was successfully created.' }
        format.json { render :show, status: :created, location: @recordpleit }
      else
        format.html { render :new }
        format.json { render json: @recordpleit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordpleits/1
  # PATCH/PUT /recordpleits/1.json
  def update
    respond_to do |format|
      if @recordpleit.update(recordpleit_params)
        format.html { redirect_to @recordpleit, notice: 'Recordpleit was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordpleit }
      else
        format.html { render :edit }
        format.json { render json: @recordpleit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordpleits/1
  # DELETE /recordpleits/1.json
  def destroy
    @recordpleit.destroy
    respond_to do |format|
      format.html { redirect_to recordpleits_url, notice: 'Recordpleit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordpleit
      @recordpleit = Recordpleit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordpleit_params
      params.require(:recordpleit).permit(:ticket_id, :n1, :n2, :siglas, :monto)
    end
end
