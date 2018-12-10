class AliasmodelosiglasorteotsController < ApplicationController
  before_action :set_aliasmodelosiglasorteot, only: [:show, :edit, :update, :destroy]

  # GET /aliasmodelosiglasorteots
  # GET /aliasmodelosiglasorteots.json
  def index
    @aliasmodelosiglasorteots = Aliasmodelosiglasorteot.all
  end

  # GET /aliasmodelosiglasorteots/1
  # GET /aliasmodelosiglasorteots/1.json
  def show
  end

  # GET /aliasmodelosiglasorteots/new
  def new
    @aliasmodelosiglasorteot = Aliasmodelosiglasorteot.new
  end

  # GET /aliasmodelosiglasorteots/1/edit
  def edit
  end

  # POST /aliasmodelosiglasorteots
  # POST /aliasmodelosiglasorteots.json
  def create
    @aliasmodelosiglasorteot = Aliasmodelosiglasorteot.new(aliasmodelosiglasorteot_params)

    respond_to do |format|
      if @aliasmodelosiglasorteot.save
        format.html { redirect_to @aliasmodelosiglasorteot, notice: 'Aliasmodelosiglasorteot was successfully created.' }
        format.json { render :show, status: :created, location: @aliasmodelosiglasorteot }
      else
        format.html { render :new }
        format.json { render json: @aliasmodelosiglasorteot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aliasmodelosiglasorteots/1
  # PATCH/PUT /aliasmodelosiglasorteots/1.json
  def update
    respond_to do |format|
      if @aliasmodelosiglasorteot.update(aliasmodelosiglasorteot_params)
        format.html { redirect_to @aliasmodelosiglasorteot, notice: 'Aliasmodelosiglasorteot was successfully updated.' }
        format.json { render :show, status: :ok, location: @aliasmodelosiglasorteot }
      else
        format.html { render :edit }
        format.json { render json: @aliasmodelosiglasorteot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aliasmodelosiglasorteots/1
  # DELETE /aliasmodelosiglasorteots/1.json
  def destroy
    @aliasmodelosiglasorteot.destroy
    respond_to do |format|
      format.html { redirect_to aliasmodelosiglasorteots_url, notice: 'Aliasmodelosiglasorteot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aliasmodelosiglasorteot
      @aliasmodelosiglasorteot = Aliasmodelosiglasorteot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def aliasmodelosiglasorteot_params
      params.require(:aliasmodelosiglasorteot).permit(:nombre, :siglasorteo, :modeloventaq, :modelocontrolq, :modeloventap, :modelocontrolp, :modeloventat, :modelocontrolt, :modeloventasp, :modelocontrolsp)
    end
end
