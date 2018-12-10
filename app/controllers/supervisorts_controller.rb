class SupervisortsController < ApplicationController
  before_action :set_supervisort, only: [:show, :edit, :update, :destroy]

  # GET /supervisorts
  # GET /supervisorts.json
  def index
    @supervisorts = Supervisort.all
  end

  # GET /supervisorts/1
  # GET /supervisorts/1.json
  def show
  end

  # GET /supervisorts/new
  def new
    @supervisort = Supervisort.new
  end

  # GET /supervisorts/1/edit
  def edit
  end

  # POST /supervisorts
  # POST /supervisorts.json
  def create
    @supervisort = Supervisort.new(supervisort_params)

    respond_to do |format|
      if @supervisort.save
        format.html { redirect_to @supervisort, notice: 'Supervisort was successfully created.' }
        format.json { render :show, status: :created, location: @supervisort }
      else
        format.html { render :new }
        format.json { render json: @supervisort.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supervisorts/1
  # PATCH/PUT /supervisorts/1.json
  def update
    respond_to do |format|
      if @supervisort.update(supervisort_params)
        format.html { redirect_to @supervisort, notice: 'Supervisort was successfully updated.' }
        format.json { render :show, status: :ok, location: @supervisort }
      else
        format.html { render :edit }
        format.json { render json: @supervisort.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supervisorts/1
  # DELETE /supervisorts/1.json
  def destroy
    @supervisort.destroy
    respond_to do |format|
      format.html { redirect_to supervisorts_url, notice: 'Supervisort was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supervisort
      @supervisort = Supervisort.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supervisort_params
      params.require(:supervisort).permit(:nombre, :apellido, :cedula, :telefono)
    end
end
