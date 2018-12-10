class ControlpleitsController < ApplicationController
  before_action :set_controlpleit, only: [:show, :edit, :update, :destroy]

  # GET /controlpleits
  # GET /controlpleits.json
  def index
    @controlpleits = Controlpleit.all
  end

  # GET /controlpleits/1
  # GET /controlpleits/1.json
  def show
  end

  # GET /controlpleits/new
  def new
    @controlpleit = Controlpleit.new
  end

  # GET /controlpleits/1/edit
  def edit
  end

  # POST /controlpleits
  # POST /controlpleits.json
  def create
    @controlpleit = Controlpleit.new(controlpleit_params)

    respond_to do |format|
      if @controlpleit.save
        format.html { redirect_to @controlpleit, notice: 'Controlpleit was successfully created.' }
        format.json { render :show, status: :created, location: @controlpleit }
      else
        format.html { render :new }
        format.json { render json: @controlpleit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controlpleits/1
  # PATCH/PUT /controlpleits/1.json
  def update
    respond_to do |format|
      if @controlpleit.update(controlpleit_params)
        format.html { redirect_to @controlpleit, notice: 'Controlpleit was successfully updated.' }
        format.json { render :show, status: :ok, location: @controlpleit }
      else
        format.html { render :edit }
        format.json { render json: @controlpleit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controlpleits/1
  # DELETE /controlpleits/1.json
  def destroy
    @controlpleit.destroy
    respond_to do |format|
      format.html { redirect_to controlpleits_url, notice: 'Controlpleit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controlpleit
      @controlpleit = Controlpleit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controlpleit_params
      params.require(:controlpleit).permit(:n1, :n2, :siglas, :limite, :vendida)
    end
end
