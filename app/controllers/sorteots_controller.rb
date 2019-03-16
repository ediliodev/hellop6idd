class SorteotsController < ApplicationController
  before_action :set_sorteot, only: [:show, :edit, :update, :destroy]

  # GET /sorteots
  # GET /sorteots.json
  def index
    @sorteots = Sorteot.all
  end

  # GET /sorteots/1
  # GET /sorteots/1.json
  def show
    redirect_to sorteots_path # Ted ok. Esto puesto para que cada vez que se ABRA o CIERRE un sorteo manualmente lo envie a la lista de sorteos (index) y no al show del sorteo updated. ok ted. 
  end

  # GET /sorteots/new
  def new
    @sorteot = Sorteot.new
  end

  # GET /sorteots/1/edit
  def edit
  end

  # POST /sorteots
  # POST /sorteots.json
  def create
    @sorteot = Sorteot.new(sorteot_params)

    respond_to do |format|
      if @sorteot.save
        format.html { redirect_to @sorteot, notice: 'Sorteot was successfully created.' }
        format.json { render :show, status: :created, location: @sorteot }
      else
        format.html { render :new }
        format.json { render json: @sorteot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sorteots/1
  # PATCH/PUT /sorteots/1.json
  def update
    respond_to do |format|
      #verificar si se puede editar/abrir el sorteo para un nuevo dia o es del dia actual:
      #if @sorteot.updated_at
      
      #Abrir el sorteo solo si esta cerrado y la fecha updated no fue cerrado hoy. o sea No se puede reabrir un sorteo cerrado en el mismo dia. Solo para un nuevo dia de venta. Esto solo se hara low level admin rails console. ok ted.
      #Esta condicion es para que no se pueda reabrir el mismo dia.
      if ( (@sorteot.abierto == "no") && (@sorteot.updated_at.to_date < Time.now.to_date) )
        #grabar cambios
        if @sorteot.update(sorteot_params)
          format.html { redirect_to @sorteot, notice: "Sorteo actualizado correctamente." }
          format.json { render :show, status: :ok, location: @sorteot }
        else
          format.html { render :edit }
          format.json { render json: @sorteot.errors, status: :unprocessable_entity }
        end
      end

      #Esta condicion es para cerrarlo (actualizar condicion de "si" o de "no") si estaba abierto
      if (@sorteot.abierto == "si")
        # si esta abierto, que se actualice como abierto o como cerrado. Depende la opcion elegida por el usuario admin web babylot.
        #grabar cambios
        if @sorteot.update(sorteot_params)
          format.html { redirect_to @sorteot, notice: "Sorteo actualizado correctamente." }
          format.json { render :show, status: :ok, location: @sorteot }
        else
          format.html { render :edit }
          format.json { render json: @sorteot.errors, status: :unprocessable_entity }
        end
      end

      # Si esta cerado y la fecha en que se cerro o actualizo ese sorteo es igual o mayor que hoy, entonces no se puede reabrir, hay que esperar manana, ya que la fecha updated sera de ayer. (menor que la de hoy)
      if ( (@sorteot.abierto == "no") && (@sorteot.updated_at.to_date >= Time.now.to_date) )
        format.html { redirect_to @sorteot, notice: "X - Este sorteo ya fue cerrado por hoy.  No se puede reabrir. Debe esperar un nuevo dia o contactar al administrador." }
      end
     
    end
  end



  # DELETE /sorteots/1
  # DELETE /sorteots/1.json
  def destroy
    @sorteot.destroy
    respond_to do |format|
      format.html { redirect_to sorteots_url, notice: 'Sorteot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sorteot
      @sorteot = Sorteot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sorteot_params
      params.require(:sorteot).permit(:nombre, :descripcion, :sigla, :abreviaturamovil, :horariosorteot_id, :loteriat_id, :activo, :abierto)
    end
end
