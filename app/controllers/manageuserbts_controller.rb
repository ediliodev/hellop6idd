class ManageuserbtsController < ApplicationController
  before_action :set_manageuserbt, only: [:show, :edit, :update, :destroy]

  # GET /manageuserbts
  # GET /manageuserbts.json
  def index
    @manageuserbts = Manageuserbt.all
    @realusers = User.all
  end

  # GET /manageuserbts/1
  # GET /manageuserbts/1.json
  def show
    redirect_to manageuserbts_path # esto para que no permita crear ni muestre el new view. ok ted. 

  end

  # GET /manageuserbts/new
  def new
    @manageuserbt = Manageuserbt.new
    redirect_to manageuserbts_path # esto para que no permita crear ni muestre el new view. ok ted. 
  end

  # GET /manageuserbts/1/edit
  def edit
  end

  # POST /manageuserbts
  # POST /manageuserbts.json
  def create
   
   redirect_to manageuserbts_path # esto para que no permita crear ni muestre el new view. ok ted. 
   #Lo demas no aplica porque la logica del controller hace un redirect el de aariba. ok ted.
    
    @manageuserbt = Manageuserbt.new(manageuserbt_params)
    @manageuserbt.modificadopor = current_user.email
     @manageuserbt.password = "********" #edito el campo password para no guardarlo plain en la DB de este Modelo.

    @reset_user =   User.where(:email => manageuserbt_params[:email]).first
    if manageuserbt_params[:password].empty? 
      redirect_to new_manageuserbt_path, notice: 'Password - No puede estar en blanco' and return
    end
      @reset_user.password =  manageuserbt_params[:password]
      @reset_user.activo =    manageuserbt_params[:activo]

    respond_to do |format|
      if @manageuserbt.save && @reset_user.save
        format.html { redirect_to root_path, notice: 'Manageuserbt was successfully created.' }
        format.json { render :show, status: :created, location: @manageuserbt }
      else
        format.html { render :new }
        format.json { render json: @manageuserbt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manageuserbts/1
  # PATCH/PUT /manageuserbts/1.json
  def update
    
    respond_to do |format|
      #if @manageuserbt.update(manageuserbt_params)
      #@email_original = manageuserbt_params[:email]
      #@obj = User.find
     # @real_user_edit.email = @email_original
      #@array_hash_params_user_update_ted = []

      @real_user_edit.gppt_id = manageuserbt_params[:gppt]
     # @real_user_edit.gppt_id = 1
      @real_user_edit.direccion = manageuserbt_params[:direccion]
      @real_user_edit.ciudadt_id = manageuserbt_params[:ciudad]
      @real_user_edit.provinciat_id = manageuserbt_params[:provincia]
      @real_user_edit.telefono = manageuserbt_params[:telefono]
      @real_user_edit.zonat_id = manageuserbt_params[:zona]
      @real_user_edit.tipousuariot_id = manageuserbt_params[:tipousuario]
      @real_user_edit.vendedor = manageuserbt_params[:vendedor]
      @real_user_edit.contacto = manageuserbt_params[:contacto]
      @real_user_edit.supervisort_id = manageuserbt_params[:supervisor]
      @real_user_edit.colectort_id = manageuserbt_params[:colector]
      @real_user_edit.sociot_id = manageuserbt_params[:socio]


    if not manageuserbt_params[:password].empty? # Solo actualizar el password de ese usuario si al momento de editar el usuario no estaba vacio l campo password. ok ted.
       @real_user_edit.password = manageuserbt_params[:password]
    end



      #if @real_user_edit.update(:email => manageuserbt_params[:email])

      if @real_user_edit.save
        format.html { redirect_to  manageuserbts_path, notice: 'Actualizado Ok.' }
        format.json { render :show, status: :ok, location: @manageuserbt }
      else
        #format.html { render :edit,  notice: "Error, verificar paramteros y contrasena de al menos 6 caracteres."  }
        @sucursal_email =  User.find(@real_user_edit).email
        redirect_to manageuserbts_path, notice: "Password invalido. Debe tener 6 caracteres o mas. Verificar todos los parametros del usuario: #{@sucursal_email}" and return
       # format.html { render :edit,  notice: "Error, verificar paramteros y contrasena de al menos 6 caracteres."  }
       # format.json { render json: @manageuserbt.errors, status: :unprocessable_entity }
      end

      #if @manageuserbt.update(manageuserbt_params)
      #  format.html { redirect_to @manageuserbt, notice: 'Manageuserbt was successfully updated.' }
      #  format.json { render :show, status: :ok, location: @manageuserbt }
      #else
      #  format.html { render :edit }
      #  format.json { render json: @manageuserbt.errors, status: :unprocessable_entity }
      #end
    end
  end

  # DELETE /manageuserbts/1
  # DELETE /manageuserbts/1.json
  def destroy
    @manageuserbt.destroy
    respond_to do |format|
      format.html { redirect_to manageuserbts_url, notice: 'Manageuserbt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manageuserbt
      #@manageuserbt = Manageuserbt.find(params[:id])
      @manageuserbt = Manageuserbt.find(params[:id]) #.first #nd(params[:id])
      @real_user_edit = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manageuserbt_params
      params.require(:manageuserbt).permit(:gppt, :direccion, :ciudad, :provincia, :telefono, :zona, :tipousuario, :vendedor, :contacto, :supervisor, :colector, :socio, :password )
    end
end

# ok ted:
#permit(:gppt, :direccion, :ciudad, :provincia, :telefono, :zona, :tipousuario, :vendedor, :contacto, :supervisor, :colector, :socio )