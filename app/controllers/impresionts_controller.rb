class ImpresiontsController < ApplicationController
  before_action :set_impresiont, only: [:show, :edit, :update, :destroy]

  # GET /impresionts
  # GET /impresionts.json
  def index
    @impresionts = Impresiont.all
  end

  # GET /impresionts/1
  # GET /impresionts/1.json
  def show
  end

  # GET /impresionts/new
  def new
    @impresiont = Impresiont.new
  end

  # GET /impresionts/1/edit
  def edit
  end

  # POST /impresionts
  # POST /impresionts.json
  def create
    @impresiont = Impresiont.new(impresiont_params)

    respond_to do |format|
      if @impresiont.save
        format.html { redirect_to @impresiont, notice: 'Impresiont was successfully created.' }
        format.json { render :show, status: :created, location: @impresiont }
      else
        format.html { render :new }
        format.json { render json: @impresiont.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /impresionts/1
  # PATCH/PUT /impresionts/1.json
  def update
    respond_to do |format|
      if @impresiont.update(impresiont_params)
        format.html { redirect_to @impresiont, notice: 'Impresiont was successfully updated.' }
        format.json { render :show, status: :ok, location: @impresiont }
      else
        format.html { render :edit }
        format.json { render json: @impresiont.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /impresionts/1
  # DELETE /impresionts/1.json
  def destroy
    @impresiont.destroy
    respond_to do |format|
      format.html { redirect_to impresionts_url, notice: 'Impresiont was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_impresiont
      @impresiont = Impresiont.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def impresiont_params
      params.require(:impresiont).permit(:ticket_id, :jugadas)
    end
end
