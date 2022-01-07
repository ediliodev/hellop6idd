class RecordspreanntsController < ApplicationController
  before_action :set_recordspreannt, only: [:show, :edit, :update, :destroy]

  # GET /recordspreannts
  # GET /recordspreannts.json
  def index
    @recordspreannts = Recordspreannt.all
  end

  # GET /recordspreannts/1
  # GET /recordspreannts/1.json
  def show
  end

  # GET /recordspreannts/new
  def new
    @recordspreannt = Recordspreannt.new
  end

  # GET /recordspreannts/1/edit
  def edit
  end

  # POST /recordspreannts
  # POST /recordspreannts.json
  def create
    @recordspreannt = Recordspreannt.new(recordspreannt_params)

    respond_to do |format|
      if @recordspreannt.save
        format.html { redirect_to @recordspreannt, notice: 'Recordspreannt was successfully created.' }
        format.json { render :show, status: :created, location: @recordspreannt }
      else
        format.html { render :new }
        format.json { render json: @recordspreannt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recordspreannts/1
  # PATCH/PUT /recordspreannts/1.json
  def update
    respond_to do |format|
      if @recordspreannt.update(recordspreannt_params)
        format.html { redirect_to @recordspreannt, notice: 'Recordspreannt was successfully updated.' }
        format.json { render :show, status: :ok, location: @recordspreannt }
      else
        format.html { render :edit }
        format.json { render json: @recordspreannt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recordspreannts/1
  # DELETE /recordspreannts/1.json
  def destroy
    @recordspreannt.destroy
    respond_to do |format|
      format.html { redirect_to recordspreannts_url, notice: 'Recordspreannt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recordspreannt
      @recordspreannt = Recordspreannt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recordspreannt_params
      params.require(:recordspreannt).permit(:ticket_id, :n1, :n2, :siglas, :monto)
    end
end
