class ActivacionclientetsController < ApplicationController
  before_action :set_activacionclientet, only: [:show, :edit, :update, :destroy]

  # GET /activacionclientets
  # GET /activacionclientets.json
  def index
    @activacionclientets = Activacionclientet.all
  end

  # GET /activacionclientets/1
  # GET /activacionclientets/1.json
  def show
    # En la accion show aprovechamos para override y hacer el reset (nil) de cliente_id por primera vez a entrar/registrar:
    @activacionclientet.clienteid = "nil"

    if @activacionclientet.save
      redirect_to activacionclientets_path, notice: "Cliente reseteado correctamente. OK. Sucursal: #{@activacionclientet.email}"  and return
    else

      redirect_to activacionclientets_path, notice: "X Error. No se pudo resetear el cliente: #{@activacionclientet.email}. Favor trate de nuevo o contacte al soporte tecnico."  and return

    end

  end

  # GET /activacionclientets/new
  def new
    redirect_to activacionclientets_path # ted esto para evitar creen una nueva entrada desde la web. provisional ok.. Que valla al index ok.
    #@activacionclientet = Activacionclientet.new
  end

  # GET /activacionclientets/1/edit
  def edit
  end

  # POST /activacionclientets
  # POST /activacionclientets.json
  def create
    @activacionclientet = Activacionclientet.new(activacionclientet_params)

    respond_to do |format|
      if @activacionclientet.save
        format.html { redirect_to @activacionclientet, notice: 'Activacionclientet was successfully created.' }
        format.json { render :show, status: :created, location: @activacionclientet }
      else
        format.html { render :new }
        format.json { render json: @activacionclientet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activacionclientets/1
  # PATCH/PUT /activacionclientets/1.json
  def update
    respond_to do |format|
      if @activacionclientet.update(activacionclientet_params)
        format.html { redirect_to @activacionclientet, notice: 'Activacionclientet was successfully updated.' }
        format.json { render :show, status: :ok, location: @activacionclientet }
      else
        format.html { render :edit }
        format.json { render json: @activacionclientet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activacionclientets/1
  # DELETE /activacionclientets/1.json
  def destroy
#    redirect_to activacionclientets_path # ted esto para evitar que borren por la web. ok. Que valla al index. provisional ok.
 
    #@activacionclientet.destroy
    respond_to do |format|
      format.html { redirect_to activacionclientets_url, notice: 'Activacionclientes no se puede eliminar por esta via. Contacte el administrador.' } # ted esto para evitar que borren por la web
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activacionclientet
      @activacionclientet = Activacionclientet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activacionclientet_params
      params.require(:activacionclientet).permit(:email, :clienteid, :tipocliente)
    end
end
