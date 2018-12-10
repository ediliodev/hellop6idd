class ControltnyntsController < ApplicationController
  before_action :set_controltnynt, only: [:show, :edit, :update, :destroy]

  # GET /controltnynts
  # GET /controltnynts.json
  def index
    @controltnynts = Controltnynt.all
  end

  # GET /controltnynts/1
  # GET /controltnynts/1.json
  def show
  end

  # GET /controltnynts/new
  def new
    @controltnynt = Controltnynt.new
  end

  # GET /controltnynts/1/edit
  def edit
  end

  # POST /controltnynts
  # POST /controltnynts.json
  def create
    @controltnynt = Controltnynt.new(controltnynt_params)

    respond_to do |format|
      if @controltnynt.save
        format.html { redirect_to @controltnynt, notice: 'Controltnynt was successfully created.' }
        format.json { render :show, status: :created, location: @controltnynt }
      else
        format.html { render :new }
        format.json { render json: @controltnynt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controltnynts/1
  # PATCH/PUT /controltnynts/1.json
  def update
    respond_to do |format|
      if @controltnynt.update(controltnynt_params)
        format.html { redirect_to @controltnynt, notice: 'Controltnynt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controltnynt }
      else
        format.html { render :edit }
        format.json { render json: @controltnynt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controltnynts/1
  # DELETE /controltnynts/1.json
  def destroy
    @controltnynt.destroy
    respond_to do |format|
      format.html { redirect_to controltnynts_url, notice: 'Controltnynt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controltnynt
      @controltnynt = Controltnynt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controltnynt_params
      params.require(:controltnynt).permit(:n1, :n2, :n3, :siglas, :limite, :vendida)
    end
end
