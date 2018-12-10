class CiudadtsController < ApplicationController
  before_action :set_ciudadt, only: [:show, :edit, :update, :destroy]

  # GET /ciudadts
  # GET /ciudadts.json
  def index
    @ciudadts = Ciudadt.all
   #params.permit(:tipo_cliente, :cliente_id)
   
    @cliente_id = params['cliente_id'] # params.permit(:tipo_cliente) #params['cliente_id'] #require(:ciudadt).permit(:cliente_id)
    @tipo_cliente = params['tipo_cliente'] # "klk" # params['tipo_cliente'] # params.require(:ciudadt).permit(:tipo_cliente)

    #tambien lo guardo en la session para fines de acceso general desde cualquier parte del servicor 9controladores)
    session[:cliente_id] = @cliente_id
    session[:tipo_cliente] = @tipo_cliente
    
  end

  # GET /ciudadts/1
  # GET /ciudadts/1.json
  def show
  end

  # GET /ciudadts/new
  def new
    @ciudadt = Ciudadt.new
  end

  # GET /ciudadts/1/edit
  def edit
  end

  # POST /ciudadts
  # POST /ciudadts.json
  def create
    @ciudadt = Ciudadt.new(ciudadt_params)

    respond_to do |format|
      if @ciudadt.save
        format.html { redirect_to @ciudadt, notice: 'Ciudadt was successfully created.' }
        format.json { render :show, status: :created, location: @ciudadt }
      else
        format.html { render :new }
        format.json { render json: @ciudadt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ciudadts/1
  # PATCH/PUT /ciudadts/1.json
  def update
    respond_to do |format|
      if @ciudadt.update(ciudadt_params)
        format.html { redirect_to @ciudadt, notice: 'Ciudadt was successfully updated.' }
        format.json { render :show, status: :ok, location: @ciudadt }
      else
        format.html { render :edit }
        format.json { render json: @ciudadt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ciudadts/1
  # DELETE /ciudadts/1.json
  def destroy
    @ciudadt.destroy
    respond_to do |format|
      format.html { redirect_to ciudadts_url, notice: 'Ciudadt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ciudadt
      @ciudadt = Ciudadt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ciudadt_params
      params.require(:ciudadt).permit(:nombre, :provinciat_id, :tipo_cliente, :cliente_id)
    end
end
