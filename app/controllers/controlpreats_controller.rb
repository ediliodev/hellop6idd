class ControlpreatsController < ApplicationController
  before_action :set_controlpreat, only: [:show, :edit, :update, :destroy]

  # GET /controlpreats
  # GET /controlpreats.json
  def index
    @controlpreats = Controlpreat.all
  end

  # GET /controlpreats/1
  # GET /controlpreats/1.json
  def show
  end

  # GET /controlpreats/new
  def new
    @controlpreat = Controlpreat.new
  end

  # GET /controlpreats/1/edit
  def edit
  end

  # POST /controlpreats
  # POST /controlpreats.json
  def create
    @controlpreat = Controlpreat.new(controlpreat_params)

    respond_to do |format|
      if @controlpreat.save
        format.html { redirect_to @controlpreat, notice: 'Controlpreat was successfully created.' }
        format.json { render :show, status: :created, location: @controlpreat }
      else
        format.html { render :new }
        format.json { render json: @controlpreat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controlpreats/1
  # PATCH/PUT /controlpreats/1.json
  def update
    respond_to do |format|
      if @controlpreat.update(controlpreat_params)
        format.html { redirect_to @controlpreat, notice: 'Controlpreat was successfully updated.' }
        format.json { render :show, status: :ok, location: @controlpreat }
      else
        format.html { render :edit }
        format.json { render json: @controlpreat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controlpreats/1
  # DELETE /controlpreats/1.json
  def destroy
    @controlpreat.destroy
    respond_to do |format|
      format.html { redirect_to controlpreats_url, notice: 'Controlpreat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controlpreat
      @controlpreat = Controlpreat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controlpreat_params
      params.require(:controlpreat).permit(:n1, :n2, :siglas, :limite, :vendida)
    end
end
