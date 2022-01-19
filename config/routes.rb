Rails.application.routes.draw do

  resources :lineatprints
  resources :controldepagogts
  resources :lineats
  get '/procesar_resultados', to: 'lineats#procesar_resultados'
  get '/tkconsultado', to: 'jugadalots#tkconsultado'

  

  resources :trabats
  resources :coliseots
  resources :recordspltknnts
  resources :recordspreannts
  resources :recordspleinnts
  resources :controlspltknnts
  resources :controlspreannts
  resources :controlspleinnts
  resources :menuadmticketsganadoresxfechats
  resources :activacionclientets
  resources :menuf10ts
  resources :controlpleits
  resources :recordtltkts
  resources :recordtnynts
  resources :recordtnytts
  resources :recordtreats
  resources :recordtleits
  resources :recordtgmts
  resources :controltltkts
  resources :controltnynts
  resources :controltnytts
  resources :controltreats
  resources :controltleits
  resources :controltgmts
  resources :recordpltkts
  resources :recordpnynts
  resources :recordpnytts
  resources :recordpreats
  resources :recordpleits
  resources :recordpgmts
  resources :controlpltkts
  resources :controlpnynts
  resources :controlpnytts
  resources :controlpreats
  resources :controlpgmts
  resources :recordqltkts
  resources :recordqnynts
  resources :recordqnytts
  resources :recordqreats
  resources :recordqleits
  resources :recordqgmts
  resources :controlqltkts
  resources :controlqnynts
  resources :controlqnytts
  resources :controlqreats
  resources :controlqleits
  resources :controlqgmts
  resources :recordspnnts
  resources :controlspnnts
  resources :recordtnnts
  resources :controltnnts
  resources :recordpnnts
  resources :controlpnnts
  resources :menuadmrresultadoglobalxsupervisorts
  resources :menuadmrresultadoglobalts
  resources :aliasmodelosiglasorteots
  resources :ticketsganadorests
  get '/menuts/calculadora', to: 'menuts#calculadora'
  get '/menuts/ayudacomando', to: 'menuts#ayudacomando'
  resources :menuts

  resources :menuposrventaxfechats
  resources :menuposrventadiaactualts
  resources :impresionts
  resources :supervisorts
  resources :ganadorests
  resources :recordqnnts
  resources :tickets
  resources :provinciats
  resources :ciudadts
  resources :sorteots
  resources :loteriats
  resources :controlqnnts
  resources :horariosorteots
  resources :mensajepiedepaginats
  resources :colectorts
  resources :sociots
  resources :zonats
  resources :gppts
  resources :consorciots
  resources :monedats
  resources :paists
  resources :continentets
  get '/jugadalots/activar', to: 'jugadalots#activar'
  get '/jugadalots/salirmanualmente', to: 'jugadalots#salirmanualmente'
  resources :jugadalots
  resources :manageuserbts
  #Definicion manual de las rutas requeridas para el modulo Devise:

  #Rutas para el custom user controller generado to override devise controller actions ok ted.
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
 

  #Rutas declaradas con el cambio de nombre en las vistas URL ok. Ted.
  #devise_for :users #, path_names: {sign_in: "login", sign_out: "logout", sign_up: "register"}


  resources :tipousuariots
  
  # root to: 'terminalposts#new'
  root to: 'jugadalots#new'

  
  resources :direccionts
  resources :empleadots
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end



#------------

#How to Remove/Disable Sign Up From Devise
#por si un dia desea modificar el login de devise sign_up, etc..
#ver link: https://stackoverflow.com/questions/39773890/how-to-remove-disable-sign-up-from-devise