class ControltnyttsController < ApplicationController
  before_action :set_controltnytt, only: [:show, :edit, :update, :destroy]

  # GET /controltnytts
  # GET /controltnytts.json
  def index
    @controltnytts = Controltnytt.all
  end

  # GET /controltnytts/1
  # GET /controltnytts/1.json
  def show
  end

  # GET /controltnytts/new
  def new
    @controltnytt = Controltnytt.new
  end

  # GET /controltnytts/1/edit
  def edit
  end

  # POST /controltnytts
  # POST /controltnytts.json
  def create
    @controltnytt = Controltnytt.new(controltnytt_params)

    respond_to do |format|
      if @controltnytt.save
        format.html { redirect_to @controltnytt, notice: 'Controltnytt was successfully created.' }
        format.json { render :show, status: :created, location: @controltnytt }
      else
        format.html { render :new }
        format.json { render json: @controltnytt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controltnytts/1
  # PATCH/PUT /controltnytts/1.json
  def update
    respond_to do |format|
      if @controltnytt.update(controltnytt_params)
        format.html { redirect_to @controltnytt, notice: 'Controltnytt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controltnytt }
      else
        format.html { render :edit }
        format.json { render json: @controltnytt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controltnytts/1
  # DELETE /controltnytts/1.json
  def destroy
    @controltnytt.destroy
    respond_to do |format|
      format.html { redirect_to controltnytts_url, notice: 'Controltnytt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controltnytt
      @controltnytt = Controltnytt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controltnytt_params
      params.require(:controltnytt).permit(:n1, :n2, :n3, :siglas, :limite, :vendida)
    end
end
