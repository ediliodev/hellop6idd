class Users::RegistrationsController < Devise::RegistrationsController
  skip_load_and_authorize_resource # Ted cancancan skip

   before_action :configure_sign_up_params, only: [:create]
before_action :configure_account_update_params, only: [:update]
before_action :configure_sign_up_params  # sign_up_params
#before_action :authenticate_user!, :redirect_unless_admin #,  only: [:new, :create] (En todos)
skip_before_action :require_no_authentication

  # GET /resource/sign_up
   def new
     super
    # flash[:notice] = "No permitido"
      
    # redirect_to "https://www.google.com" and return # "https://www.google.com"
   end

  # POST /resource
   def create
    super
 
   end

  # GET /resource/edit
   def edit
     super

   end

  # PUT /resource
   def update
     super
   end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

#OJO EN ESTA PARTE DE DEVISE PODEMOS AGReGAR PARAMETros ADICIONALES OK TED:

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :created_at, :updated_at, :telefono, :sucursalt_id, :tipousuariot_id, :activo, :consorciot_id, :sucursalbt, :siglas, :direccion, :ciudadt_id, :provinciat_id, :zonat_id, :vendedor, :contacto, :supervisort_id, :colectort_id, :sociot_id, :gppt_id])
   end

 def configure_sign_in_params
     devise_parameter_sanitizer.permit(:sign_ip, keys: [:email, :created_at, :updated_at, :telefono, :sucursalt_id, :tipousuariot_id, :activo, :consorciot_id, :sucursalbt, :siglas, :direccion, :ciudadt_id, :provinciat_id, :zonat_id, :vendedor, :contacto, :supervisort_id, :colectort_id, :sociot_id, :gppt_id])
   end


  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [:email, :created_at, :updated_at, :telefono, :sucursalt_id, :tipousuariot_id, :activo, :consorciot_id, :sucursalbt, :siglas, :direccion, :ciudadt_id, :provinciat_id, :zonat_id, :vendedor, :contacto, :supervisort_id, :colectort_id, :sociot_id, :gppt_id])
   end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end


#:email
#:created_at
#:updated_at
#:telefono
#:sucursalt_id
#:tipousuariot_id
#:activo
#:consorciot_id
#:sucursalbt
#:siglas
#:direccion
#:ciudadt_id
#:provinciat_id
#:zonat_id
#:vendedor
#:contacto
#:supervisort_id
#:colectort_id
#:sociot_id
#:gppt_id

#:email, :created_at, :updated_at, :telefono, :sucursalt_id, :tipousuariot_id, :activo, :consorciot_id, :sucursalbt, :siglas, :direccion, :ciudadt_id, :provinciat_id, :zonat_id, :vendedor, :contacto, :supervisort_id, :colectort_id, :sociot_id, :gppt_id




  private


  def redirect_unless_admin


      if not current_user
        #Esto si no esta logeado ni es admin, debe estar logeado y ser admin para poder crear usuario, redireccionar ok.
        flash[:notice] = "ERROR x - Debes estar logeado y ser admin para esta accion. Este incidente sera reportado. Favo contactar Central."
        redirect_to root_path and return
      end
      
        #if current_user.email == "edilio69@hotmail.com"
        if current_user.tipousuariot_id  != 2 # Si no es admin. Verificar que curent_user sea admnin antes de crear usuarios.
          flash[:notice] = "ERROR x - Crear un usuario nuevo Requiere autorizacion administrativa. Favor contactar Central"
          redirect_to root_path and return
        
        end

    #Si la logica llega hasta aqui, es porque todo ok: current_user es admin y puede proceder al new registration controller users ok ted.

  end # fin  de la funcion redirect_unless_admin



  def configure_sign_up_params_ted

     params.permit(:consorciot, :sucursalbt, :siglas, :vendedor, :contacto)
    #ppediente de completar, de lo contrario la asigacion la haremos com params directo del borwser al modelo...? (like session[:id_cliente] y session[:tipo_cliente]) ...+/*
  end




end # fin de la clase.
