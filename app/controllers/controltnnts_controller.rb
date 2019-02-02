class ControltnntsController < ApplicationController
  before_action :set_controltnnt, only: [:show, :edit, :update, :destroy]

  # GET /controltnnts
  # GET /controltnnts.json

  def index

   # @controltnnts = Controltnnt.all
   @controltnnts = Controltnnt.all.order(:vendida => :desc).limit(100)

  end

  # GET /controltnnts/1
  # GET /controltnnts/1.json
  def show
  end

  # GET /controltnnts/new
  def new
    @controltnnt = Controltnnt.new
  end

  # GET /controltnnts/1/edit
  def edit
  end

  # POST /controltnnts
  # POST /controltnnts.json
  def create
    @controltnnt = Controltnnt.new(controltnnt_params)

    respond_to do |format|
      if @controltnnt.save
        format.html { redirect_to @controltnnt, notice: 'Controltnnt was successfully created.' }
        format.json { render :show, status: :created, location: @controltnnt }
      else
        format.html { render :new }
        format.json { render json: @controltnnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controltnnts/1
  # PATCH/PUT /controltnnts/1.json
  def update
    respond_to do |format|
      if @controltnnt.update(controltnnt_params)
        format.html { redirect_to @controltnnt, notice: 'Controltnnt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controltnnt }
      else
        format.html { render :edit }
        format.json { render json: @controltnnt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controltnnts/1
  # DELETE /controltnnts/1.json
  def destroy
    @controltnnt.destroy
    respond_to do |format|
      format.html { redirect_to controltnnts_url, notice: 'Controltnnt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controltnnt
      @controltnnt = Controltnnt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controltnnt_params
      params.require(:controltnnt).permit(:n1, :n2, :n3, :siglas, :limite, :vendida)
    end
end
