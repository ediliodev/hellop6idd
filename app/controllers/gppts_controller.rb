class GpptsController < ApplicationController
  before_action :set_gppt, only: [:show, :edit, :update, :destroy]

  # GET /gppts
  # GET /gppts.json
  def index
    @gppts = Gppt.all
  end

  # GET /gppts/1
  # GET /gppts/1.json
  def show
  end

  # GET /gppts/new
  def new
    @gppt = Gppt.new
  end

  # GET /gppts/1/edit
  def edit
  end

  # POST /gppts
  # POST /gppts.json
  def create
    @gppt = Gppt.new(gppt_params)

    respond_to do |format|
      if @gppt.save
        format.html { redirect_to @gppt, notice: 'Gppt was successfully created.' }
        format.json { render :show, status: :created, location: @gppt }
      else
        format.html { render :new }
        format.json { render json: @gppt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gppts/1
  # PATCH/PUT /gppts/1.json
  def update
    respond_to do |format|
      if @gppt.update(gppt_params)
        format.html { redirect_to @gppt, notice: 'Gppt was successfully updated.' }
        format.json { render :show, status: :ok, location: @gppt }
      else
        format.html { render :edit }
        format.json { render json: @gppt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gppts/1
  # DELETE /gppts/1.json
  def destroy
    @gppt.destroy
    respond_to do |format|
      format.html { redirect_to gppts_url, notice: 'Gppt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gppt
      @gppt = Gppt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gppt_params
      params.require(:gppt).permit(:nombre, :q1, :q2, :q3, :p12, :p13, :p23, :sp, :t123, :t13, :t23)
    end
end
