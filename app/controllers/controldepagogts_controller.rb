class ControldepagogtsController < ApplicationController
  before_action :set_controldepagogt, only: [:show, :edit, :update, :destroy]

  # GET /controldepagogts
  # GET /controldepagogts.json
  def index
    @controldepagogts = Controldepagogt.all
  end

  # GET /controldepagogts/1
  # GET /controldepagogts/1.json
  def show
  end

  # GET /controldepagogts/new
  def new
    @controldepagogt = Controldepagogt.new
  end

  # GET /controldepagogts/1/edit
  def edit
  end

  # POST /controldepagogts
  # POST /controldepagogts.json
  def create
    @controldepagogt = Controldepagogt.new(controldepagogt_params)

    #verifiar siempre que el limite x ticket sea menor al limie global por logica ok:
    if not( @controldepagogt.limitexticket <= @controldepagogt.limiteglobal )
          redirect_to "/controldepagogts/new", notice: "Limite x Ticket debe ser Menor o igual al Limite Global. NO PUEDE EXCEDER EL LIMITE GLOBAL DEFIINITO. VERIFICAR." and return   
    end
    respond_to do |format|
      if @controldepagogt.save
        format.html { redirect_to @controldepagogt, notice: 'Controldepagogt was successfully created.' }
        format.json { render :show, status: :created, location: @controldepagogt }
      else
        format.html { render :new }
        format.json { render json: @controldepagogt.errors, status: :unprocessable_entity }
      end
    end
  
  end # fin de la funcion create


  # PATCH/PUT /controldepagogts/1
  # PATCH/PUT /controldepagogts/1.json
  def update
    #verifiar siempre que el limite x ticket sea menor al limie global por logica ok:
    p = controldepagogt_params
    limite_ticket = p[:limitexticket].to_i
    limite_global = p[:limiteglobal].to_i
    if not( limite_ticket <= limite_global )
          redirect_to "/controldepagogts/", notice: "X. El limite por ticket debe ser menor o igual (<=) al Limite Global. VERIFICAR." and return   
    end
    
    respond_to do |format|
      if @controldepagogt.update(controldepagogt_params)
        format.html { redirect_to @controldepagogt, notice: 'Controldepagogt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controldepagogt }
      else
        format.html { render :edit }
        format.json { render json: @controldepagogt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controldepagogts/1
  # DELETE /controldepagogts/1.json
  def destroy
    @controldepagogt.destroy
    respond_to do |format|
      format.html { redirect_to controldepagogts_url, notice: 'Controldepagogt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controldepagogt
      @controldepagogt = Controldepagogt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controldepagogt_params
      params.require(:controldepagogt).permit(:tipojugada, :limitexticket, :limiteglobal)
    end
end
