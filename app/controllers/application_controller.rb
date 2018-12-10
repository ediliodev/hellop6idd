class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #Hacer que el user se auntetique por devise antes de ejecutar cualquier controlador por ahora (sin excep :show.. ) ok
  before_action :authenticate_user!
  #load_and_authorize_resource 
 
  #configurar strong params para permitir campos adicionales del User.rb sign_up (nombre, aellido de usuario, etc..)
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nombre, :apellidos, :telefono, :tipousuariot_id, :sucursalt_id] )
  end


end
