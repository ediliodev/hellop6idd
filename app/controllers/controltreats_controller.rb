class ControltreatsController < ApplicationController
  before_action :set_controltreat, only: [:show, :edit, :update, :destroy]

  # GET /controltreats
  # GET /controltreats.json
  def index
    @controltreats = Controltreat.all
  end

  # GET /controltreats/1
  # GET /controltreats/1.json
  def show
  end

  # GET /controltreats/new
  def new
    @controltreat = Controltreat.new
  end

  # GET /controltreats/1/edit
  def edit
  end

  # POST /controltreats
  # POST /controltreats.json
  def create
    @controltreat = Controltreat.new(controltreat_params)

    respond_to do |format|
      if @controltreat.save
        format.html { redirect_to @controltreat, notice: 'Controltreat was successfully created.' }
        format.json { render :show, status: :created, location: @controltreat }
      else
        format.html { render :new }
        format.json { render json: @controltreat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controltreats/1
  # PATCH/PUT /controltreats/1.json
  def update
    respond_to do |format|
      if @controltreat.update(controltreat_params)
        format.html { redirect_to @controltreat, notice: 'Controltreat was successfully updated.' }
        format.json { render :show, status: :ok, location: @controltreat }
      else
        format.html { render :edit }
        format.json { render json: @controltreat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controltreats/1
  # DELETE /controltreats/1.json
  def destroy
    @controltreat.destroy
    respond_to do |format|
      format.html { redirect_to controltreats_url, notice: 'Controltreat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controltreat
      @controltreat = Controltreat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controltreat_params
      params.require(:controltreat).permit(:n1, :n2, :n3, :siglas, :limite, :vendida)
    end
end
