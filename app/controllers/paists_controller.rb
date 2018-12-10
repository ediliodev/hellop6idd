class PaistsController < ApplicationController
  before_action :set_paist, only: [:show, :edit, :update, :destroy]

  # GET /paists
  # GET /paists.json
  def index
    @paists = Paist.all
  end

  # GET /paists/1
  # GET /paists/1.json
  def show
  end

  # GET /paists/new
  def new
    @paist = Paist.new
  end

  # GET /paists/1/edit
  def edit
  end

  # POST /paists
  # POST /paists.json
  def create
    @paist = Paist.new(paist_params)

    respond_to do |format|
      if @paist.save
        format.html { redirect_to @paist, notice: 'Paist was successfully created.' }
        format.json { render :show, status: :created, location: @paist }
      else
        format.html { render :new }
        format.json { render json: @paist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paists/1
  # PATCH/PUT /paists/1.json
  def update
    respond_to do |format|
      if @paist.update(paist_params)
        format.html { redirect_to @paist, notice: 'Paist was successfully updated.' }
        format.json { render :show, status: :ok, location: @paist }
      else
        format.html { render :edit }
        format.json { render json: @paist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paists/1
  # DELETE /paists/1.json
  def destroy
    @paist.destroy
    respond_to do |format|
      format.html { redirect_to paists_url, notice: 'Paist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paist
      @paist = Paist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paist_params
      params.require(:paist).permit(:nombre, :continentet_id)
    end
end
