class ProvinciatsController < ApplicationController
  before_action :set_provinciat, only: [:show, :edit, :update, :destroy]

  # GET /provinciats
  # GET /provinciats.json
  def index
    @provinciats = Provinciat.all
  end

  # GET /provinciats/1
  # GET /provinciats/1.json
  def show
  end

  # GET /provinciats/new
  def new
    @provinciat = Provinciat.new
  end

  # GET /provinciats/1/edit
  def edit
  end

  # POST /provinciats
  # POST /provinciats.json
  def create
    @provinciat = Provinciat.new(provinciat_params)

    respond_to do |format|
      if @provinciat.save
        format.html { redirect_to @provinciat, notice: 'Provinciat was successfully created.' }
        format.json { render :show, status: :created, location: @provinciat }
      else
        format.html { render :new }
        format.json { render json: @provinciat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /provinciats/1
  # PATCH/PUT /provinciats/1.json
  def update
    respond_to do |format|
      if @provinciat.update(provinciat_params)
        format.html { redirect_to @provinciat, notice: 'Provinciat was successfully updated.' }
        format.json { render :show, status: :ok, location: @provinciat }
      else
        format.html { render :edit }
        format.json { render json: @provinciat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /provinciats/1
  # DELETE /provinciats/1.json
  def destroy
    @provinciat.destroy
    respond_to do |format|
      format.html { redirect_to provinciats_url, notice: 'Provinciat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provinciat
      @provinciat = Provinciat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provinciat_params
      params.require(:provinciat).permit(:nombre, :paist_id)
    end
end
