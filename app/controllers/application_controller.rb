class ApplicationController < ActionController::Base
  #skip_check_authorization

  protect_from_forgery with: :exception

  #Hacer que el user se auntetique por devise antes de ejecutar cualquier controlador por ahora (sin excep :show.. ) ok
 # before_action :authenticate_user!

#config.to_prepare do
#  Devise::SessionsController.skip_before_action :verificar_permisos
#end

# if not :devise_controller?  # ESTO SE CREO PARA QUE NO DE ERROR EN EL DEVISE CONTROLLER PORUQE AQUI LA CLASE ABILITY NO LANZA ERROR UE QUE PUSE LOAD_AND_AUTHORIZE EN APPLICATION_CONTROLLER O SEA QUE VA A VERIFICAR CANCACAN EN TODAS PARTES INCLUYENDO DEVISE LOGIN/LOGOUT, POR ESO HICE UNA EXCEPCION PARA ESTE CONTROLADOR Y FUNCIONA OK TED.
#    load_and_authorize_resource #verificar permisos de CRUD en cada recurso/ modelo socicitado por el cliente.
# end

#if current_user? #not :devise_controller?  # ESTO SE CREO PARA QUE NO DE ERROR EN EL DEVISE CONTROLLER PORUQE AQUI LA CLASE ABILITY NO LANZA ERROR UE QUE PUSE LOAD_AND_AUTHORIZE EN APPLICATION_CONTROLLER O SEA QUE VA A VERIFICAR CANCACAN EN TODAS PARTES INCLUYENDO DEVISE LOGIN/LOGOUT, POR ESO HICE UNA EXCEPCION PARA ESTE CONTROLADOR Y FUNCIONA OK TED.
#    load_and_authorize_resource #verificar permisos de CRUD en cada recurso/ modelo socicitado por el cliente.
# end



 load_and_authorize_resource
 

  #configurar strong params para permitir campos adicionales del User.rb sign_up (nombre, aellido de usuario, etc..)
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nombre, :apellidos, :telefono, :tipousuariot_id, :sucursalt_id] )
  end




end
