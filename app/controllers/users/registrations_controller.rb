class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

before_action :authenticate_user!, :redirect_unless_admin,  only: [:new, :create]
  skip_before_action :require_no_authentication

  private
  def redirect_unless_admin
#if current_user == nil

#flash[:notice] = "Must Login First.ok."
#redirect_to root_path
#end
   # unless current_user.try(:admin?)
    #unless ( current_user.try(:nombre) == "Savier" )
    

# if current_user # si inicio sesion. se crea un current_uer, de lo contrario el guest user es nil.

# unless ( current_user.try(:tipousuariot) == 1 ) # Si current_user no es un "admin" no agrego usuarios y lo mando al menu principal (porque ya esta logeado como "ventas", "superviosr", etc, menos admin. Nota: si no estuviera logeaddo el aunthenticate_user! helper lo manda al login de deivse).
# flash[:notice] = "Only admins can do that ted ok."
# redirect_to root_path
# end

  if current_user
    if current_user.email == "edilio69@hotmail.com"
     flash[:notice] = "admin lo que sea aqui..."
     #sign_up
    # redirect_to root_path and return


    else # no es necesario pero me aseguro de que ese current_user no cree nuevos usuarios, mejor lo mando para el main menu root_path.
      flash[:notice] = "Crear un usuario nuevo Requiere autorizacion. Favor contactar Central"
      redirect_to root_path and return
    
    end
  end # end del if current_user

 #flash[:notice] = "Crear un usuario nuevo Requiere Login y autorizacion. Favor contactar Central"
  #    redirect_to root_path and return

 end # and de la funcion redirect_unless_admin






  # GET /resource/sign_up
 #  def new
 #    super
     #flash[:notice] = "No permitido"
      
     #redirect_to root_path # "https://www.google.com"
 #  end

  # POST /resource
 #  def create
  #   super
 # redirect_to root_path
 #  end

  # GET /resource/edit
  # def edit
  #   super
  #redirect_to "https://www.google.com"
  # end

  # PUT /resource
  # def update
  #   super
  # end

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

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
