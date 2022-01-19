class JugadalotsController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_jugadalot, only: [:edit, :update, :destroy]
  before_action :verificar_reconexion_de_usuario # Esto si el usuario esta loggeado desde ayer o mas viejo y si tiene cosas pendientes... etc.. session destroy y forzar login.

  # GET /jugadalots
  # GET /jugadalots.json
  
  def activar
   # flash[:notice] = "klkkkk"
   
    session[:cliente_id] =  "desktop" # SETEADO MANUAL ADMINISTRATIVAMENTE OK TED.
    session[:tipo_cliente]  =  "123" # SETEADO MANUAL ADMINISTRATIVAMENTE OK TED.

    @tipo_cliente = "desktop" # SETEADO MANUAL ADMINISTRATIVAMENTE OK TED.
    @cliente_id =   "123" # SETEADO MANUAL ADMINISTRATIVAMENTE OK TED.
    session[:chekeado] = "chekeado"

   if (session[:terminal_autorizada] == false)
     sign_out(current_user) 
   end
   session[:terminal_autorizada] = true
    #creado para complemento (convention over configuration) del controlador del view de acticion de equipos. ok ted.
  end

  def salirmanualmente
    reset_session # para la salidda definitiva descomentar  #before_action :authenticate_user! arriba y va a generar un cancan errror, luego funciona bn ok ? provisional o que el usuario informe su salida y lo desabilitamos manual de manera temporal ok ted.
   # session.clear
    #sign_out current_user 

   # @userp = User.find(current_user)
    #@user.update_attributes(current_sign_in_token: "")
   # @userp.update_attributes(last_sign_in_at: "Mon, 17 Dec 2100 00:24:23 -04 -04:00".to_d)
   # current_user.last_sign_in_at = Date.tomorrow
   sign_out_and_redirect(current_user)


  end

  def index
     # @jugadalots = Jugadalot.all
     if current_user #Verificar id y tipo de cliente que solicita (esto para ver si es cliete celular app, para modificar la vista html de presentacion mejor para la app ok ted.)
      session[:cliente_id] = params['cliente_id'] # params.permit(:tipo_cliente) #params['cliente_id'] #require(:ciudadt).permit(:cliente_id)
      session[:tipo_cliente]  = params['tipo_cliente'] # "klk" # params['tipo_cliente'] # params.require(:ciudadt).permit(:tipo_cliente)
      
       session[:cliente_id] =  "desktop" # SETEADO MANUAL ADMINISTRATIVAMENTE OK TED.
       session[:tipo_cliente]  =  "123" # SETEADO MANUAL ADMINISTRATIVAMENTE OK TED.
       session[:chekeado] = "chekeado"

      session[:ubicacion] = params['ubicacion']
      
      #session[:esperar_ubicacion] 
      #redirect_to "/jugadalots/new", notice: "Procesado ok. Bienvenido al sistema.Cliente_id: #{session["cliente_id"]} , Tipo_cliente: #{session[:tipo_cliente]}" and return 
      redirect_to "/jugadalots/new" and return      
     end
  end

  # GET /jugadalots/1
  # GET /jugadalots/1.json
  def show
    # redirect_to "/jugadalots/new", notice: "NO PERMITIDO SHOW." and return 
    # Ahora entra en la parte de la vista. Esta contiene el ticket a enviar para la impresion.
  end

  # GET /jugadalots/new
  def new

    # -------------------------------------------------------------------
    #provisional para simepre capturar el ticket id session
    if  session[:ticket_id] != nil # Me aseguro que el ticket exista antes de asignarlo. ok. 
      @jugadalot.ticket_id = session[:ticket_id] # asocio la jugada con su ticket actual correspondiene.
    else
      #asignar un nuevo ticket id, evitar eror de page isnt redirecting properly dado en NY ok:
      @t_id = request_ticket_id()
      session[:ticket_id] = @t_id

      redirect_to "/jugadalots/new", notice: "Ej. 01 |Azul|Blanco|+|-| (OK). ($) 100 (OK). (A)nular:/atSERIAL, (C)onsultar, (P)agar /pt222+123456, (?)100 Posible pago, (X) Borrar todo. " and return 
    end
    # -------------------------------------------------------------------

    @tipo_cliente = session[:tipo_cliente] #capturo el tipo de cliente verificado en index y almacenado en la session para llegar al new y usar esta variable de control para motrar la vista web o mobile. ok. ted.
    @cliente_id = session[:cliente_id]
    #SETEAR FIJO EL TIPO CLIENTE Y EL CLIENTE_ID POR AHORA OK. DESABILITADO MANUALMENTE ADMISTRATIVAMENTE FUNCIONALIDAD OK TED.
    
    session[:cliente_id] =  "desktop" # SETEADO MANUAL ADMINISTRATIVAMENTE OK TED.
    session[:tipo_cliente]  =  "123" # SETEADO MANUAL ADMINISTRATIVAMENTE OK TED.

    @tipo_cliente = "desktop" # SETEADO MANUAL ADMINISTRATIVAMENTE OK TED.
    @cliente_id =   "123" # SETEADO MANUAL ADMINISTRATIVAMENTE OK TED.
    session[:chekeado] = "chekeado"


    # LINEA PROVISIONAL DEBAJO
    # redirect_to "/jugadalots/activar", notice: "Bienvenido, Favor configure el printer para continuar. Si no puede pasar de esta pantalla, favor contactar a la central para verificar si su terminal esta activada. Gracias." and return 
    # redirect_to "/jugadalots/activar", notice: "Error: Debe activar su terminal, favor contactar la Central. Cierre y abra la aplicacion nuevamente o Reconfigure el printer para obviar este mensaje." and return 

    
    if  not( @chekeado = session[:chekeado]) # && session[:ya_chekeado] != 'si') # si no se ha chekeado en la session, chekearlo!!

      if (current_user && @tipo_cliente && @cliente_id)  
        @equipo_existe = Activacionclientet.where(:email => current_user.email).first #.nil? 

        if @equipo_existe.nil?
          @registro_nuevo_equipo = Activacionclientet.new
          @registro_nuevo_equipo.email = current_user.email
          @registro_nuevo_equipo.clienteid = @cliente_id
          @registro_nuevo_equipo.tipocliente = @tipo_cliente
          @registro_nuevo_equipo.save
        end

         if not @equipo_existe.nil? # si existe, comparamos 
          
            if (@equipo_existe.clienteid == @cliente_id) && (@equipo_existe.tipocliente == @tipo_cliente)
              session[:chekeado] = "chekeado"
            end

            if (@equipo_existe.clienteid == "nil") # reset, crearlo. Lo de "nil" es porque el atribuo es del tipo string. ok provisional ted.
              @equipo_existe.email = current_user.email
              @equipo_existe.clienteid = @cliente_id
              @equipo_existe.tipocliente = @tipo_cliente
              @equipo_existe.save
              session[:chekeado] = "chekeado"
            end

            if (@equipo_existe.clienteid != @cliente_id) || (@equipo_existe.tipocliente != @tipo_cliente)
              session[:chekeado] = nil
              session[:terminal_autorizada] = false
              redirect_to "/jugadalots/activar", notice: "Error: Su terminal no esta autorizada. Favor contactar a la Central para su reset." and return 
            end

          else # si no se cumple alguna condicion de "if not @equipo_existe.nil?" entonces nil default.
            session[:chekeado] = nil # ok ted.
          end
     
        else
        @tipo_cliente =  @cliente_id = nil # Para que no le permita el view de venta. (Le Sale el otro view de no venta.. ok ted.)
       # session[:ya_chekeado] = 'si'
        redirect_to "/jugadalots/activar", notice: "Bienvenido44! Favor configure el printer para continuar. [Presione el boton rojo BABYLOT 2.0 y luego el azul PROBAR IMPRESION]... o contacte a la Central para verificar su activacion. Gracias." and return 
       end

    end
      
    @jugadalot = Jugadalot.new
    # @jugadalots = Jugadalot.all Para mostrar todas las jugadas, solo queremos las de un ticket id especifico.
    @ticket =  last_tickect_current_user()
    @total = 0 # Total de monto apuestas de ticket.
    @efectivo_recibido = session[:efectivo_recibido] # Dinero recibido del cliente para pagar su ticket.
    session[:efectivo_recibido] = nil

    if  @ticket && (@ticket.fechaimpresion == nil) # mostrar jugadas si el ticket no esta impreso. >> && @ticket hace que no de error si el usuario es nuevo, creado y no ha hecho ticket aun. ok te.
      @jugadalots = Jugadalot.where(:ticket_id => @ticket.id) # Todos estos ticket. no va last ni first, son all. ok Ted.
      session[:jugadalots_get_tk_id]  = @ticket.id # Esto para referenciarlo en el show y mostrar las jugadas apostadas en ese tk ok ted.


      @jugadalots.each do |jugadalot|
        @total += jugadalot.monto.to_i
      end
      session[:total_tk_viejo] =  @total # esto porque al imprimit el /new [].each es 0.
    
    else
      @jugadalots = [] # en vez de nil para que cumpla con el array.each... nil.ech no existe.
      session[:jugadalots_get_tk_id]  = "" # nada por ahora.
    end

  #Setear y enviar la hora del serven el la pantalla del PoSale usando session storate (el contep local del tiempo en la pc/pos sigue con javascript)
  #session[:horas] = Time.now.strftime("%H-%M-%S").split("-")[0] 
  #session[:minutos] = Time.now.strftime("%H-%M-%S").split("-")[1]
  #session[:segundos] = Time.now.strftime("%H-%M-%S").split("-")[2]
  #session[:fecha] = Date.today

  #verificar ubicacion klk:

    if session[:esperar_ubicacion] == "si" # flag modificado on/off en la parte de impresion del procgrama. impresion de ticket. ok ted.
      
      @mostrar_coordenadas = false #true    # flag de mostrar activo. (Se desactiva en new.html ok ted.)
      @ubicacion =  session[:ubicacion] #variable a mostrar la ubicacion en la vista new de esta accion. ok ted.

     # @ubicacion = params[:ubicacion] # => nil o string eje.: "19.442154,-70.7125487"

      #actualizar ubicacion del ultimo ticket impreso de este current user, impresio casi ahora.
      #Ejemplo:
      @tkgps = Ticket.where(:user_id => current_user.id).last # el last es el nuevo ticket vacio, el previous fue el impreso, ok ted.
     
      if ( @ubicacion ) # Esto para que el split no de error de nil.split, en caso de que suceda. (me sucedio una sola vez en prueba)
        @tkgps.latitud = @ubicacion.split(",")[0]      
        @tkgps.longitud = @ubicacion.split(",")[1]      
        @tkgps.save
      end

      session[:esperar_ubicacion] = "no"

    end


  end # fin de la accion new


  # GET /jugadalots/1/edit
  def edit
  end

  # POST /jugadalots
  # POST /jugadalots.json
  def create

    
    if session[:ticket_id] == nil # primer login o sin ticket...?
      @t_id = request_ticket_id()
      session[:ticket_id] = @t_id
    end


#----------------------

#   h1 =  params.require(:jugadalot).permit(:qpt)
#   v1 = h1[:qpt]
#
#   if v1.empty? 
#    redirect_to "/jugadalots/new", notice: "NO PUEDE ESTAR EN BLANCO" and return 
#  end
#----------------------

   
   entrada_hash = params.require(:jugadalot).permit(:qpt)
   entrada = entrada_hash[:qpt] # Valor del hash. ok. ted.

  if entrada.empty? 
    redirect_to "/jugadalots/new", notice: "NO PUEDE ESTAR EN BLANCO" and return 
  end
   
   @stt = "888" # No borrar por ahora no se. Dejarlo asi. No pesa nada dejarlo ok. ted. Old Megamilion variable.
  
   # Aqui podemos trabajar la parte de multijuegos/
   #entrada => 02+10.01//10+05//0220+10//031625+5.01//, etc... 

#FORMA DE HACER COMENTARIO D MULTIPLES LINEAS: =begin ..... =end OK TED.
=begin

   case entrada

         #Verificar si son repeticiones de jugadas para otro sorteo: ej. r01.02
         when /^r\d{2}\.\d{2}$/ # r01.02 Repeticion de jugadas en sorteo xx
          if  session[:ticket_id] != nil # Me aseguro que el ticket exista antes de asignarlo. ok. 
              @ticket_repetir = session[:ticket_id] # asocio la jugada con su ticket actual correspondiene.
          else
               redirect_to "/jugadalots/new", notice: "No se pueden repetir jugadas sin ticket asignado. Favor borrar todo (/bt) y trate de nuevo, realice por separado o contacte la Central." and return 
          end

          entrada.slice!(0) #Elimino el primer valor de la cadena de caracteres (string). Elimino la "r"
          entrada = entrada.split(".") #=> [01, 02] Separo valores. nota no se puede hacer entrada.slice(0).split(".") porque el slice devuelve el char cortado. por eso lo hacemos en dos pasos para conseguir el split(".") ok. 
          @sorteo_origen = entrada[0]  #=> 01
          @sorteo_destino = entrada[1] #=> 02
          #verificar que sorteos digitados existan antes de proceder:
          @verificar_s1 = sorteo_existe?(@sorteo_origen) #=> true si existe o false si no existe.
          @verificar_s2 = sorteo_existe?(@sorteo_destino) #=> true si existe o false si no existe.
          
          if ( (not @verificar_s1) || (not @verificar_s2)  )
               redirect_to "/jugadalots/new", notice: "X No se pueden repetir jugadas porque algun sorteo ingresado no existe. Favor verificar sorteos disponibles o contacte la Central." and return 
          end


          entrada = cargar_comandos_jugadas_repetir_otro_sorteo(@ticket_repetir, @sorteo_origen , @sorteo_destino)
          
          if entrada.empty? || entrada.nil?
            redirect_to "/jugadalots/new", notice: "No se encuentran jugadas de ese sorteo para repetirlo en otro." and return 
          end
          #Buscar todos los comandos de todas las jugadaslots de ese ticket con ese sorteo de origen.
          #Hacer un string comandos.join("*")
          #Hacer un string.replace pattern .01 a .02 (sorteo_origen, sorteo_destino)
          #dejar que siga evaluando hacia abajo... ok ted. Bloque de codigo guardar jugadas.
        else
   end
   
=end
  # fin del comentario largo multiple de arriba ok.


   entrada = entrada.split("*") #esto era para multiples comando en la misma linea del sistema babylot ok. por ahora el split sera de uno gallos ok.

   entrada.each do |entrada|
       @jugadalot = Jugadalot.new(jugadalot_params) # Creo nueva instacia (objeto) para registro de cada jugadalot. ok. ted.
        
      
      #AQUI VAMOS A TRANSFORMAR EL CMONDO DE JUGADA A TIMEPO EN NUMEROS PARA SEGUIR LA LOGICA DEL PROGRAMA:
      #EJ. 0103 ES PELEA 1 A MENOS TIMEPO LLEVARLO DE 01- A 0103 PARA EL case entrada CONDITION LO PROCESE NORMAL SEGUN LA LOGICA DE 4 DIGITOS OK TED.

      if entrada =~ /^\d{2}\-$/ # este operador me permite hacer el matcheo con la regrex ok. (tambien pude haberlo hecho con la logica del bloque case entrada ... end ok). sacado del link: https://stackoverflow.com/questions/9861611/using-regex-in-ruby-if-condition
        entrada = entrada[0..1].to_s + "03" # convierte "01-"" en "0103" por ejemplo comando ok.  
      end

      if entrada =~ /^\d{2}\+$/
        entrada = entrada[0..1].to_s + "04" # convierte "01+"" en "0104" por ejemplo comando ok.  
      end

      #Aceptar modo de comando de pelea "01a" o "01A"   (azul) => llevarlo a  "0101". Lo mismo con el cinta blanca ok.
      if entrada =~ /^\d{2}[a, A]$/ # este operador me permite hacer el matcheo con la regrex ok. (tambien pude haberlo hecho con la logica del bloque case entrada ... end ok). sacado del link: https://stackoverflow.com/questions/9861611/using-regex-in-ruby-if-condition
        entrada = entrada[0..1].to_s + "01" # convierte "01-"" en "0103" por ejemplo comando ok.  
      end

      if entrada =~ /^\d{2}[b, B]$/
        entrada = entrada[0..1].to_s + "02" # convierte "01+"" en "0104" por ejemplo comando ok.  
      end



      
      #Aqui va la parte del controlador con el case..end ok ted.
      #Evaluar cada tipo de comando o peticion:
       case entrada

        #parte de comandos de gallos: 

        #la parte de \d\d\+ || \d\d\- la haremos luego.
        when /^\d{4}$/  # Si son cuatro digitos Old quiniela command: when /^\d{2}\+\d+$/   ej. 02+100 #Verificar si es Quiniela
          #  redirect_to "/jugadalots/new", notice: "TODO OK BABY 4 O 6 DIGITOS" and return 

            @comado_jugada = entrada 
            peleanumero  = @comado_jugada[0..1]
            apuestacinta = @comado_jugada[2..3]

            #verifcar apuestacinta sea un comando valido esperado:
            apuestacintaisok = ["01", "02", "03", "04"].include?(apuestacinta) # Verificar que esta parte del comando is ok. retorna true o false ok. 
            if not apuestacintaisok
              redirect_to "/jugadalots/new", notice: "X. Tipo de apuesta invalido." and return 
            end

            #ubicar pelea en la Linea de hoy:
            p = Lineat.where(:pelea => peleanumero.to_i).today.first # retorna el objeto o nil. not nil => true ok ted.

            if not (p)
              redirect_to "/jugadalots/new", notice: "X. Pelea no encontrada. Verifique por favor." and return 
            end
            
            #verificar que la pelea exista en la linea de hoy:
            #verificar que: exista hoy, este abierta, disponibilidad x ticket y global
            #nota para despues: que exista, que este abierta, que haya disponibilidad o verificar la dispo al final calculando el monto... ok.
            #p =  Lineat.where(:pelea => peleanumero).today.first
            if p.status == "abierta"
              #realizar ingreso de la apuesta al modelo de jugadalots
              #@jugadalot = Jugadalot.new # Ya esta creada en el metodo new ok, create la procesa ok. Jugadalot(id: integer, n1: integer, n2: integer, n3: integer, monto: integer, qpt: string, created_at: datetime, updated_at: datetime, ticket_id: integer, sorteot_id: integer, comandojugada: string, pelea: string, apuestacinta: string, ml: string, posiblepago: string, acierto: string, resultado: string, pagoreal: string)
              #Jugadalot(id: integer, n1: integer, n2: integer, n3: integer, monto: integer, qpt: string, created_at: datetime, updated_at: datetime, ticket_id: integer, sorteot_id: integer, comandojugada: string, pelea: string, apuestacinta: string, ml: string, posiblepago: string, acierto: string, resultado: string, pagoreal: string)

              #inscribo la jugada por partes:
              #comandojugada, pelea, apuestacinta, ml, posiblepago, acierto, resultado, pagoreal
              @jugadalot.comandojugada = @comado_jugada # string like 0102, pelea 1 al blanco ok.
              @jugadalot.pelea = p.pelea.to_i

              #verificar apuestacinta:
              if apuestacinta == "01"
                cinta = "azul"
              end

              if apuestacinta == "02"
                cinta = "blanco"
              end

              if apuestacinta == "03"
                cinta = "-"
              end

              if apuestacinta == "04"
                cinta = "+"
              end
              
              @jugadalot.apuestacinta = cinta

              #ml:
              #determinar el ml del azul, del blanco, del - y del +, segun corresponda:
              if cinta == "azul"
                moneyline = p.mla
              end

              if cinta == "blanco"
                moneyline = p.mlb
              end

              if cinta == "-"
                moneyline = p.oua
              end

              if cinta == "+"
                moneyline = p.oub
              end

              @jugadalot.monto = 0 # 0 por el momento.
              @jugadalot.ml = moneyline 
              #aignar el ticket_id de esta entraga de jugadalot. Nota si no existe salir ok.
              if session[:ticket_id] != nil # Me aseguro que el ticket exista antes de asignarlo. ok. 
                 @jugadalot.ticket_id = session[:ticket_id] # asocio la jugada con su ticket actual correspondiene.
              else
                redirect_to "/jugadalots/new", notice: "No ticket_id de session asignado. Favor borrar todo (/bt) y trate de nuevo. Gracias." and return 
              end
              @jugadalot.n1 = 1 # llenar requisitos only
              @jugadalot.n2 = 1 # llenar requisitos only
              @jugadalot.n3 = 1 # llenar requisitos only
              @jugadalot.qpt = "Q" # llenar requisitos only
              @jugadalot.sorteot_id = 1 # llenar requisitos only
              #@jugadalot.comandojugada ok asignado arriba ok
              #@jugadalot.pelea ok asignado arriba ok
              #@jugadalot.apuestacinta ok asignado arriba ok
              #@jugadalot.ml ok asignado arriba ok

              @jugadalot.posiblepago = 0 # provisional
              @jugadalot.acierto = "pendiente" # provisional
              @jugadalot.resultado = "pendiente" # provisional Creo que hay que obviar este atributo.
              @jugadalot.pagoreal = 0 # provisional

              #verificar no hayan jugadas repetidas ni contradictorias antes de salvar el registro
              existen_jugadas_repetidas = verificar_jugadas_repetidas(@jugadalot)
              existen_jugadas_contradictorias = verificar_jugadas_contradictorias(@jugadalot)

              if existen_jugadas_repetidas
                redirect_to "/jugadalots/new", notice: "X. Jugada repetida." and return               
              end

              if existen_jugadas_contradictorias
                redirect_to "/jugadalots/new", notice: "X. Jugada contradictoria. Verificar." and return               
              end
          
              if @jugadalot.save
                redirect_to "/jugadalots/new", notice: "Registrado Ok." and return               
              else
                redirect_to "/jugadalots/new", notice: "X. No Registrado." and return  #Esto indica que no se pudo guardar pero solo se le notifica al digitador. Verificar causa del not saved ok. ted. Debug en caso de este error. Verificar los logs. ok.
              end

            elsif p.status == "cerrada"
                redirect_to "/jugadalots/new", notice: "X. Pelea Cerrada." and return               
            else
                #cualquier otra condicion fuera de abierta o cerrada, no disponible. ok.
                redirect_to "/jugadalots/new", notice: "X. Pelea no disponible." and return               
            end  # fin del bloque (if p.status == "abierta") ok.

            redirect_to "/jugadalots/new", notice: "Mostrando resultado: #{@jugadalot.comandojugada}, #{@jugadalot.pelea}, #{@jugadalot.apuestacinta}, #{@jugadalot.ml} " and return 

           #POR AHORA CREO QUE NUCNA LLEGA AQUI DEBAJO OK:

            @cadena = entrada.split("+")
            @quiniela = @cadena[0]
            @monto = @cadena[1]
            @jugadalot.qpt = "Q"
            @jugadalot.n1 = @quiniela
            @jugadalot.monto = @monto.to_i
            @jugadalot.comandojugada = @comado_jugada # ej. "02+100.01"
            

            if  session[:loteria_manual] != nil
              #verificar que el sorteo seteado exista antes de asignarlo y seguir trabajando:
              #sorteo_existe?(session[:loteria_manual].to_s)
              #Aqui lo de arriba no sera necesario ya que al setear cualquier sorteo manual el sistema valida que exita primero, si no existe sale un error indicado que 'debe setear una loteria'. Lo mismo aplica para q, pale y tripletas con sorteo seteados manual. La validacion de que el sorteo exita la realizamos en la entradas de q,t,p con especificacion de sorteo manual. Ej. Q 02+10.01 , 0220+10.03 y 010101+10.04, para eviar un sorteo raro ej. 0220+10.88?? ok ted. done. resuelto.
              @jugadalot.sorteot_id = Sorteot.where(:sigla => session[:loteria_manual].to_s).first.id  # "Next" Proximo sorteo del dia de hoy disponible. O sea sorteo actual abierto hora de cierre menor es el primero en cerrar.

            else
               @mensaje2 = "Debe setear una Loteria."
               redirect_to "/jugadalots/new", notice: "No se pudo grabar esta jugada en ticket porque debes setear o especificar un sorteo de una loteria para la jugada. Ej. 01+01.01 Favor intentar nuevamente." and return 
            end


            if  session[:ticket_id] != nil # Me aseguro que el ticket exista antes de asignarlo. ok. 
              @jugadalot.ticket_id = session[:ticket_id] # asocio la jugada con su ticket actual correspondiene.
            else
               redirect_to "/jugadalots/new", notice: "No se pudo grabar esta jugada porque no tiene un ticket_id de session asignado. Favor borrar todo (/bt) y hace nueva jigada con contacte la Central." and return 
            end

          
             
            if verificar_disponibilidad_simple(@jugadalot) < 0
              redirect_to "/jugadalots/new", notice: "Cantidad no disponible para jugada: #{entrada}"  and return 
            end

            if session[:loteria_manual] != nil &&  @jugadalot.save 
              #redirect_to "/jugadalots/new"  and return 
            else
              redirect_to "/jugadalots/new", notice: "No se pudo grabar esta jugada en ticket_line. Error. " + "#{@mensaje2}" + "#{session[:loteria_manual]}" and return 
            end


         when /^[.]\d+$/ #procesar peticion de calculo de posible pago de la apuesta
          
          if session[:ticket_id] != nil # Me aseguro que el ticket exista antes de asignarlo. ok. 
            @jugadalot.ticket_id = session[:ticket_id] # asocio la jugada con su ticket actual correspondiene.
          else
            redirect_to "/jugadalots/new", notice: "No ticket_id de session asignado. Favor borrar todo (/bt) y trate de nuevo. Gracias." and return 
          end


          posible_pago = procesar_posible_pago(@jugadalot.ticket_id, entrada) # la funcion retorna nil, o array con 3 elementos ok
          if posible_pago == nil
            redirect_to "/jugadalots/new", notice: "X. No existen jugadas. Debe realizarla primero."  and return             
          end

          #Procesar comando para un maximo de x combinaciones permitidas: Septimetas 7 ok ted:
          if (Jugadalot.where(:ticket_id => last_tickect_current_user).count > 8) # el objeto es el tipo array.size method is ok
            redirect_to "/jugadalots/new", notice: "X Max.8 combinaciones por ticket. Eliminar adicionales." and return # 
          end

          #Dar formato a las cantidades de efectico usando los separadoes de miles ok:
          apostado = ActionController::Base.helpers.number_to_currency(posible_pago[0], :unit => "$", :delimiter => ",", :precision => 0, :separator => ".")
          ganancia = ActionController::Base.helpers.number_to_currency(posible_pago[1], :unit => "$", :delimiter => ",", :precision => 0, :separator => ".")
          acobrar = ActionController::Base.helpers.number_to_currency(posible_pago[2], :unit => "$", :delimiter => ",", :precision => 0, :separator => ".")
          redirect_to "/jugadalots/new", notice: "Jugadas. Apostado: #{apostado} +  Ganancia: #{ganancia} =  A COBRAR: #{acobrar}"  and return 





         #WORKINGNOW:
         when /^\.{2}\d+$/ # Ej. "..500" procesar regsitro e impresion del ticket. Este si va a la venta.
          #1 verificar que existan jugadas antes de cobrrar o procesar cualquier intento de pago OK
          #2 verificar cantidad mayor que cero. OK.
          #3 procesar posible pago de la cantidad apostada.
          #4 verificar limites de apuestas [ticket y global]
          #5 registrar ticket a ventas, etc
          
          #1 verificar que existan jugadas antes de cobrrar o procesar cualquier intento de pago
          jugadas  =  Jugadalot.where(:ticket_id => last_tickect_current_user) || []
          if (jugadas == []) # esto es posible en rails probado ok. Si no hay jugadas returnal nil para que envie mensaje de realizar jugadas primero ok  ted. Ver la logica del progrma que invoca esta funcion ok.
            redirect_to "/jugadalots/new", notice: " X. Debe de realizar las jugadas a procesar." and return 
          end

          #verificarmonto de la apuesta sea positivo: > 0.
          if entrada.split("..")[1].to_i <= 0
            redirect_to "/jugadalots/new", notice: "Apuesta debe ser mayor que cero" and return # todos.            
          end

          #redirect_to "/jugadalots/new", notice: "probando 123..." and return # todos.

            @efectivo_recibido = entrada.split(".")[2].to_i #efectivo recibido ..100 split(".)[2] => 100


            #verificar sorteos abiertos de esas jugadalots de ese ticket.
            #verificar disponibilidad nuevamente y descontar montos disponibles
            #Guardar en las tablas corresponidiente de quinieles, pales o tripletas, etc.
            #Guardar con el posible pago arriba ok.
            #cotejar el ticket con fecha de impresion
            #imprimir
            #Tema de procesamiento de reusltados
            #reporte de ventas y resultados in, out, net
            
            
            #verificacion de sorteos abiertos.
            # @sorteo_cerrado = verificar_sorteo_cerrado(last_tickect_current_user())  # retorna array[] o false. ok ted. ver funcion.
            @pelea_cerrada = verifcar_alguna_pelea_cerrada(last_tickect_current_user()) 
            # if @sorteo_cerrado
            if (@pelea_cerrada) # el objeto es el tipo array.size method is ok
              redirect_to "/jugadalots/new", notice: "Alguna pelea cerrada: " + "#{@pelea_cerrada.join(",")}" and return # todos.
            end

            #sacar la venta posible pago x array de 7 posiciones.
            #Ticket.today.ids.each do |tk_id|
            #si jugadalot.where(:tik => tk_id).all.count == 2 >> pale, sumar en array pale+= etc, retorna 7 elementos sumas totales x parlays posiciones only y listo.

            @parlay_count = Jugadalot.where(:ticket_id => last_tickect_current_user).count

            if (@parlay_count > 8) # el objeto es el tipo array.size method is ok
              redirect_to "/jugadalots/new", notice: "X Max.8 combinaciones por ticket. Eliminar adicionales." and return # 
            end

            #verificar limites de pago x ticket 
            if excede_control_de_pago_x_ticket(last_tickect_current_user, entrada) # posible_pago = procesar_posible_pago(@jugadalot.ticket_id, entrada) # la funcion retorna nil, o array con 3 elementos ok. Lo mando porque voy a invocarla dentro de esta funcion que acabo de llamar ok.
              redirect_to "/jugadalots/new", notice: "X. El Posible pago excede maximo x ticket." and return # 
            end

            #verificar limites de pago x ticket 
            if excede_control_de_pago_x_ticket_x_parlay(last_tickect_current_user, entrada) # posible_pago = procesar_posible_pago(@jugadalot.ticket_id, entrada) # la funcion retorna nil, o array con 3 elementos ok. Lo mando porque voy a invocarla dentro de esta funcion que acabo de llamar ok.
              redirect_to "/jugadalots/new", notice: "X. Sumatoria de Riesgo excede el maximo global x tipo de parlay." and return # 
            end

            #verificar limites de pago global
            if excede_control_de_pago_global()
              redirect_to "/jugadalots/new", notice: "X. Sumatoria de Riesgo excede el Maximo Global General." and return # 
            end



           # redirect_to "/jugadalots/new", notice: "probando todas abiertas ok" and return # todos.

          #Continuar con gallos los siguientes procesos:
          #verificar disponibilidad global ok
          #procesar posible pago
          #registrar ticket a ventas
          #imprimir
          total_posible_riesgo_de_pago_parlay = suma_posible_pago_parlay(@parlay_count) # posible pago riesgo total de parlays, directo, pale, tripl, etc..
         #funcion de abajo no definida por el momento, imaginaria ok.
         # disponibilidad_global =  cant_disponibilidad_global(@parlay_count) # retorna la cantidad de disp. global de ese parlay
          
          #algunos ajustes para asegurar correcta asignacion del ticket id de session ok:

          if session[:ticket_id] != nil # Me aseguro que el ticket exista antes de asignarlo. ok. 
            @jugadalot.ticket_id = session[:ticket_id] # asocio la jugada con su ticket actual correspondiene.
          else
            redirect_to "/jugadalots/new", notice: "No ticket_id de session asignado for process tk ok. Favor (/bt) trate de nuevo. Gracias." and return 
          end


          #modificar entrada de ..500 a .500 por ejempo para cumplir con la funcion de abajo que era de analisis cuando se definio ok:
          entrada = entrada[1..(entrada.size-1)] # "..250 => .250" para que cumplacon el ajuste del string enviado adentro de la funcion de abajo ok.
          posible_pago = procesar_posible_pago(@jugadalot.ticket_id, entrada) #  posible pago del ticket completo, diferente a pago real, depende si hay empates o nulos computados ok.. la funcion retorna nil, o array con 3 elementos ok
          

          #********************************
          apostado = posible_pago[0]
          ganancia = posible_pago[1] 
          acobrar =  posible_pago[2] 
          #********************************
          #asignacion en variables de seesion para el show impresion del ticket tamebien ok:
          session[:apostado_tk] = apostado
          session[:ganancia_tk] = ganancia
          session[:acobrar_tk] =  acobrar
          

          @last_jugada = jugadas.last # elijo el ultimo elemnto del array de jugadads del ticket actual para poner el posible pago y monto del conjunto de jugadas que conforman ese ticket. ok. sacado de arriba, justo debajo del when, de esta line a de codigo ok:   Jugadalot.where(:ticket_id => last_tickect_current_user) 
          
          @last_jugada.monto = apostado
          @last_jugada.posiblepago = acobrar

          if not (@last_jugada.save) # salvar posible pago de la ultima jugada de ese grupo de jugadas que pertenecen al mismo ticket ok, de lo contrario limpiar y hacer de nuevo si se presento un error guardando .save ok.
            redirect_to "/jugadalots/new", notice: "Error en procesamiento posible pago jugadas, borre (/bt) y trate de nuevo." and return # todos.
          end

          

         #redirect_to "/jugadalots/new", notice: "probando todas abiertas ok, estamos trabajando hasta aki..." and return # todos.


          #AL insertar la cantidad para generar e imprimir el ticket de venta se hace la sgte logica:
          #1-generar el monto y posible pago de las jugadas realizadas
          #2-relfejarlo en el Ticket model que hace referenca a todas esas jugadas de Jugadalot de ese ticket ok.


          #Algunos atributos de Jugadalot.last pdtes hasta ahora:
          #monto
          #posiblepago: #computar
          #acierto:  # cuando se procesen los resultados
          #resultado # cuando se procesen los resultados
          #pagoreal  # cuando se procesen los resultados
           #pos ahora computar a ventas e imprimir tk ok

          #La parte de arriba de control de pago max x disp global sera obviada por el momento, debido a que falta ir descontando lo vendido de la disp global y sumando el montode posible pago del last ticket para determinar el limite actual del max de rirego  global , for later ok.
          # Esto se pueve considerar en ticket sumatoria de posible pagos de todos los da hoy y por ahi establecer un control provisional de control de ventas y posbible riesgo de pago, uqe la suma no exceda un max seteado antes de registrar el prox ticket? transitorio ok.
          
           #para despues, postpuesto para gallos 1 ok.
           #@verficiar_disponibilidad = verificar_disponibilidad_global(last_tickect_current_user)
           
           # if ! (@verficiar_disponibilidad.empty?)
           #     redirect_to "/jugadalots/new", notice: "Algunas jugadas con Cantidad no disponible: \n" +  "#{@verficiar_disponibilidad.join(" ")}" and return # todos.                
           # end
           

          #  @disponibilidad = verificar_disponibilidad(last_tickect_current_user())  # retorna array[] o false. ok ted. ver funcion.
          #  if @disponibilidad
          #  redirect_to "/jugadalots/new", notice: "Algun sorteo cerrado: " + "#{@a.join(",")}" and return 
          #  end

            if true   # OJO SI BORRAS EL IF, DEBES BORRAR EL END del mismo al final. ok. Buscarlo. (Que el sorteo este abierto y que se autorice imprimir)
             # if verificar_sorteo_cerrado? && @impresion = imprimir_ticket # imprimir y marcar como impreso
             @cotejo_tk = last_tickect_current_user()
             
            #El siguiente if piede ayudar para evitar que se reimprima un ticket si le dan para atras en el navegador(browser) alguine inventando con un ticket ya impreso en esos momentos; ok ted provisional klk? eviar impresion. 
            if @cotejo_tk.fechaimpresion != nil
              #Tambien hay que limipar algunas cosasse session ticekt info refresh Provisional secutiry. ok ted. Hacer lo miso en el js after print klk vista later ok.
              session[:apostado_tk] = "0 x n/a"
              session[:ganancia_tk] = "0 x n/a"
              session[:acobrar_tk] =  "0 x n/a"
              redirect_to "/jugadalots/new", notice: "Ticket impreso no se puede reimprimir. Favor /bt borrar todo y hacer un nuevo ticket para continuar." and return
            end
           
            #Nota, colocamos el registro de la venta despues de la validacion impresion nil, porue se estaba registrando venta antes de ver si ya estaba reimpreso. NO se debe registrar venta si esta reimpreso. ok. ted. la validacion y el redirect_to va primtero para evitar eso. ok. ted. (Ya que se estaban registradon ticket conv etas sin ser impresio.) ok
            #si pasa esa condicion, entonces estan todos disponibles. Vamos a descontar de las respectivas tabalas de disponibilidad
            #luego registramos la venta de las jugada en la tabla de venta de quinielas (en este caso)
            #luego vamos a marcar el ticket como impreso y este estara en la venta y candidato al sorteo si no se anula en tiempo prudente.
         

            #postpuesto para gallos 2 ok
            #@descuento_y_registro_venta = descontar_disponibilidad_y_registrar_venta(last_tickect_current_user)
            
            #if @descuento_y_registro_venta == false
            #    redirect_to "/jugadalots/new", notice: "No se pudo descontar disponibilidad o registrar venta en la tabla. Favor llame a la Central." and return
            #end  

             @cotejo_tk.fechaimpresion = Time.now # todos.
             @cotejo_tk.activo = "si" # ticket activo. si de anula debemos cambiar este status.
             session[:efectivo_recibido] =  @efectivo_recibido
             #@cotejo_tk.pago = acobrar  # este es el posible pago atributo llamado asi en el modelo, el otro el el pago real .pagoreal ttribute ok ted.
             @cotejo_tk.parlay = parlay_count_name # setear el parlay del ticket: pale, directo, tripleta, etc...
             session[:parlay_count_nombre] = parlay_count_name # esto para pasarlo al shor por medio de session variables para la impresion del cuerpo del ticket ok.

            if @cotejo_tk.save 
               
               #redirect_to "/jugadalots/new", notice: "probando todas abiertas ok, estamos trabajando hasta aki..." and return # todos.

               session[:ticket_id] = nil  # activo flag para generar nuevo ticket.
               #imprimir_ticket() funcion o javascript klk...
               @consorcio_interno = Consorciot.where(:id => current_user.consorciot_id.to_i).first # Provisional, hasta que arreglemos la relacion has_many entre User y modelo Consorciot. ok ted. 
               
               session[:consorcio] = @consorcio_interno.nombre || "GFFNA"
               session[:telefono] = @consorcio_interno.telefono || " "
               session[:siglas] = current_user.siglas || "xx"
               session[:ticket] = @cotejo_tk.id.to_s 
               session[:serial] = @cotejo_tk.serial
               #session[:hora_impresion] = @cotejo_tk.fechaimpresion.strftime("%d/%m/%Y (%H:%M:%S)") # strftime("%I:%M%P")
               session[:hora_impresion] = @cotejo_tk.fechaimpresion.strftime("%d/%m/%Y (%I:%M%P)") # strftime("%I:%M%P")
               session[:mensaje1] =  "Buena Suerte !" 
               session[:mensaje2] =  "Revise y Conserve su ticket para fines de pago."
               session[:barcode] = @cotejo_tk.id.to_i

               #organizar jugadas para la impresion por sorteo:
               #NOTA: VER SI SE PUEDE HACER STO EN LA VISTA DEL SHOW EN UN PARRAFO, ASI NO HAY PROBLEMAS DE SESSION COOKIES OVERSIZE. OK. TED.
               @ticketb =  last_tickect_current_user()

               @st = "" # para las jugadas a imprimir
               @sorty = "" # para el titulo del sorteo en la impresion del ticket.

                 if  (@ticketb)
                    @jugadalotsb = Jugadalot.where(:ticket_id => @ticketb.id).order(sorteot_id: :desc) # Organizo por sorteo descendente para fines de impresion.
                    
                    if @jugadalotsb == nil # esto para evitar problemas con primera vez de nuevo usuario que no tenga tickets o jugadalots.. ok +/- ted.
                      @sorty = "nada"
                    else
                      @sorty = @jugadalotsb.first.sorteot.nombre
                    end


                    @n1 = ""
                    @n2 = ""
                    @n3 = ""
                    @font = "|2C"
                    @st = "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + " + %Q{"#{@font}"} + " + " + " " + %Q{"#{@sorty}:"}  + " + LF);"
                    # @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT," +  %Q{"#{@sorty}:"} + " + LF);"  ESTE ERA EL FONT TRADICIONAL VIEJO ORIGINAL. TAMANIO PEQUENIO.

                    @jugadalotsb.each do |jugadalot|
                        @klk1 = jugadalot.qpt
                        @monto = jugadalot.monto
                    
                          if @klk1 == "Q"
                            @n1 = jugadalot.n1.to_s.rjust(2,"0")
                            @n2 = "  "
                            @n3 = "  "
                          end
                          
                          if @klk1 == "P"
                            @n1 = jugadalot.n1.to_s.rjust(2,"0")
                            @n2 = jugadalot.n2.to_s.rjust(2,"0")
                            @n3 = "  "
                          end
                        
                          if @klk1 == "T"
                              @n1 = jugadalot.n1.to_s.rjust(2,"0")
                              @n2 = jugadalot.n2.to_s.rjust(2,"0")
                              @n3 = jugadalot.n3.to_s.rjust(2,"0")
                          end
                     
                     #Luego de la evaluacion de formato de impresion de pales, verifico si es superpale para renombrarlo en la impresion del ticket ok ted:
                      if ( jugadalot.sorteot.sigla.to_i ==  13 || jugadalot.sorteot.sigla.to_i == 14 || jugadalot.sorteot.sigla.to_i ==  17 )
                          @klk1 = "SP" # Esto para que se vea impreso como super pale, la jugada. ok.
                      end
                     


                      if @sorty == jugadalot.sorteot.nombre
                       
                        @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@klk1} #{@n1} #{@n2} #{@n3}   $#{@monto}"} + " + LF);"
                      else
                        @sorty = jugadalot.sorteot.nombre

                        @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + " + %Q{"#{@font}"} + " + " + " " + %Q{"#{}"}  + " + LF);" # Hace un espacio para separar las jugadas del Nombre de los sorteos. ok. Estetica ted.ok.
                        @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + " + %Q{"#{@font}"} + " + " + " " + %Q{"#{@sorty}:"}  + " + LF);"
                        #@st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT," +  %Q{"#{@sorty}:"} + " + LF);"  FONT VIEJO TAMANIO PEQ. ORIGINAL DEFAULT JAVAPOS
                        #@st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT," +  %Q{ " #{@klk1} #{@n1}  #{@n2}  #{@n3}   $#{@monto}"} + " + LF);"
                        @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@klk1} #{@n1} #{@n2} #{@n3}   $#{@monto}"} + " + LF);"
                      end
                    
                    end   

                      @impresion = Impresiont.new()
                      @impresion.ticket_id = @ticketb.id
                      @impresion.jugadas = @st
                      # session[:jugadas_impresa] = @st Evitaremos cookie memory syse overflow. guardando en DB.
                      @st = "" # Limpio el string.
                      
                      if not (@impresion.save!)
                          redirect_to "/jugadalots/new", notice: "No se pudo procesar la informacion: impresiont. Favor intentar nuevamente o contactar a la Central." and return

                      end              

                    session[:jugadas_impresa_index] = @impresion.id # Guardo la referencia del id guradado para consultarlo en el Show con Impresiont.find(session[:jugadas_impresa_index]).jugadas ok ted.

                    @total = 0
                    @jugadalotsb.each do |jugadalot|
                      @total = jugadalot.monto.to_i
                    end

                    session[:total_impreso] =  @total

                  
                    


                    #verificar si el cliente es movil, hacer el cuerpo de impresion movil:
                    if ( (session[:tipo_cliente] == "movil") || true )

                        @st_movil = ""

                        @st_movil_consorcio =  session[:consorcio]  
                        @st_movil_telefono = session[:telefono] 
                        @st_movil_siglas = session[:siglas]
                          
                        @st_movil_ticket = session[:ticket]
                        @st_movil_serial = session[:serial]
                        @st_movil_fecha = session[:hora_impresion]
                        



                        @lineas_jugadas = @impresion.jugadas.split(";") # Separo las lineas de instruccion jugadas por ; de java. ok.
                        
                        @lineas_jugadas.each do |fila|
                        
                          fila = fila[67..fila.size]
                          fila = fila.split("\\")[0]
                          fila = fila.split("\"")[0] # para filtar algunos caracteres basura que salieron impreso. ok.ted.
                          @st_movil << fila.to_s + "@@"

                        end
                        @st_movil += "@@"
                        @st_movil_total = session[:total_impreso].to_s 
                        
                        
                        
                        @st_movil_mensaje =   session[:mensaje1].to_s

                        
                        session[:st_movil] = @st_movil  # pasar valores por session porque este controlador no relaciona las variables globales con la vista show ok ted.
                        session[:esperar_ubicacion] = "no"

                        # manejo y registro de ubucacion (session movil debe ser true, ok. entonces manda ubicacion gps el celular)


                    end




                end
                 @id_valido_provisional_show_relleno_get_ted = Jugadalot.first.id 
              #Debajo tuve que hacer esto: /jugadalots/id porque el show de cancancan verifica si puedes acceder al modelo, la accion y el id del elemento. Cuando activo cancancan si pongo esto /jugadalot/show, sale un error. pero asi si funciona ok. nota no pongo el id=1 porque si no esta sale nil y da errr. ok. ted. cualquiera primero que exista. Provisional funcional ok. ted.  
               redirect_to "/jugadalots/#{@id_valido_provisional_show_relleno_get_ted}", notice: "Procesando Ticket y enviando a imprimir..." and return 
            end # end provisional , aqui manda else error.

         # end

          else
          #Ticket no se puede imprimir porque el sorteo esta cerrado. marcar ticket como no valido.
            redirect_to "/jugadalots/new", notice: "No se pudo imprimir, no se pudo setear el ticket.fechaimpresion o algo relacionado. Favor reitente, reset o llame la Central." and return 
          end



















         #Verificar si es seteo de loteria manual
         when /^\.\d{2}+$/ # Setear loteria manual
            redirect_to "/jugadalots/new", notice: "No permitido en GFF " + "#{entrada}" and return #saltar esto.

            entrada.slice!(0) # el slice elimina el . del .02 ok ted.
            
              @verificar0 = sorteo_existe?(entrada)

              @verificar2 = false 

              if @verificar0
                @verificar1 = session[:loteria_manual] = entrada
                @buscar_sorteo_objeto = Sorteot.where(:sigla => "#{entrada}").first
                @sorteo_nombre_ted = @buscar_sorteo_objeto.nombre

                @array_horas = []
                @array_horas << @hora_domingo_sorteo_seteado = @buscar_sorteo_objeto.horariosorteot.domingo.strftime("%I:%M%P")
                @array_horas << @hora_lunes_sorteo_seteado = @buscar_sorteo_objeto.horariosorteot.lunes.strftime("%I:%M%P")
                @array_horas << @hora_martes_sorteo_seteado = @buscar_sorteo_objeto.horariosorteot.martes.strftime("%I:%M%P")
                @array_horas << @hora_miercoles_sorteo_seteado = @buscar_sorteo_objeto.horariosorteot.miercoles.strftime("%I:%M%P")
                @array_horas << @hora_jueves_sorteo_seteado = @buscar_sorteo_objeto.horariosorteot.jueves.strftime("%I:%M%P")
                @array_horas << @hora_viernes_sorteo_seteado = @buscar_sorteo_objeto.horariosorteot.viernes.strftime("%I:%M%P")
                @array_horas << @hora_sabado_sorteo_seteado = @buscar_sorteo_objeto.horariosorteot.sabado.strftime("%I:%M%P")

      
                @hora_sorteo_seteado = @array_horas[Time.now.wday].to_s

                #@hora_sorteo_seteado = "00:00"
                @sorteo_nombre_ted += " (" + @hora_sorteo_seteado  + ")"

                @verificar2 = session[:loteria_manual_nombre] =  @sorteo_nombre_ted 
              end           

            if @verificar0 && @verificar1 && @verificar2
              redirect_to "/jugadalots/new", notice: "Sorteo seteado: " + "#{entrada}" + " - " + @sorteo_nombre_ted  and return 

            else
              redirect_to "/jugadalots/new", notice: "No se pudo setear este sorteo: " + "#{entrada}" and return 
            end
         

          #Verificar la hora y fecha en el servidor (por el cliente PoS):  
          when "/h" # Consultar la hora y fehca del servidor.
            redirect_to "/jugadalots/new", notice: "La fecha y hora actual en el servidor es: #{Time.now.strftime("%d/%m/%Y (%H:%M:%S)")}"  and return 

           when "/bt"  # #borrar todo. Linea de ticket jugadalots actual.
            session[:efectivo_recibido] = nil
            session[:total_tk_viejo] = nil
            borrar_todo_jugadalots_actual(last_tickect_current_user)
            #session[:ticket_id] = nil # actvio flag para genrear un nuevo ticket mejor.
            redirect_to "/jugadalots/new", notice: "Jugadas en Limpio...ok. " and return 

          #vamosporaki:
        



          # SECCION DE TICKET - CONSULTA - PAGO Y ANULACION:

         when /^\/at\d+\+\d+$/ # Anular ticket "/at123456+8855522" 
              @dataframe = entrada.split("+")
              @ticket_anular = @dataframe[0].to_s[3..(@dataframe[0].size-1)]
              @serial_anular = @dataframe[1]

              #ticket existe con informacion suministrada?
              @t_valido = Ticket.where(:id => @ticket_anular , :serial => @serial_anular).first
             
           


              if not @t_valido
                redirect_to "/jugadalots/new", notice: "X No se puede anular este ticket, razon: Ticket o Serial invalido. Favor verificar nuevamente " and return 
              end

              #verificar que no sea un ticket pago, un ticket pago no se puede anular porque se rebajaria de la venta, no es posible anular algo ya pagado ok.
              if (@t_valido.pago == "si")
                redirect_to "/jugadalots/new", notice: "X Este ticket no se anula porque ya fue pagado. Un ticket pago no se anula. Incidente reportado." and return 
              end


              #verificar que sea de este usuario/sucursal:
              if (@t_valido.user_id != current_user.id) && (current_user.tipousuariot_id != 2) # || (not current_user.admin? o !=2 ok.)
                redirect_to "/jugadalots/new", notice: "X Este usuario no puede anular este ticket. No eres admin ni el ticket es este usuario." and return 
              end

              #Verificar si el ticket no es de HOY (Tambien podemos verificar  con la gema by_star y es de hoy y hace 10min. o menos de realizado o tiene mas de ahi.. PENDIENTe)
              if not (Ticket.by_day(Date.today).ids).include?(@t_valido.id)
                redirect_to "/jugadalots/new", notice: "X Este ticket no puede ser anulado. No es de hoy. Favor verificar" and return 
              end

              #etc.. entre otras condiciones a veriicar despues..
              #NOTA: >> HAY QUE ITERAR EL TICKET Y VERICIAR QUE NO HAYAN SORTEOS CERRADOS EN ESE TICKET PARA QUE SE PUEDA ANULAR.  CON UNO SOLO QUE ENCUENTRES CERRADO NO SE PUEDE ANULAR ESE TICKET, OK TED PENDIENTE.

              # Condicional NO se pueden anular tickets pasado 10 minutos de su impresion:
              if ( @t_valido.fechaimpresion < (Time.now - 5.minutes) && current_user.tipousuariot_id != 2 )# diferente de 2 (no admin); si es true, pasaron 10minutos, no se puede anular por aqui. con este usuario
                redirect_to "/jugadalots/new", notice: "X Este ticket no puede ser anulado pasado 5 minutos. Favor explicar  al cliente o llamar a la Central." and return 
              end




              #verifcar_algun_sorteo_cerrado de @ticekt.

              #@algun_sorteo_cerrado = verifcar_algun_sorteo_cerrado(@t_valido)
              #if @algun_sorteo_cerrado
              #  redirect_to "/jugadalots/new", notice: "X Este ticket no puede ser anulado. Ya tiene sorteos cerrados: " + "#{@algun_sorteo_cerrado.join(",")}" and return 
              #end

              @alguna_pelea_cerrada = verifcar_alguna_pelea_cerrada(@t_valido)
              if @alguna_pelea_cerrada
                redirect_to "/jugadalots/new", notice: "X No se puede anular este ticket. Ya tiene peleas cerradas: " + "#{@alguna_pelea_cerrada.join(",")}" and return 
              end

             # redirect_to "/jugadalots/new", notice: "proceder a anular..." and return 
              #proceder a anular:

              @t_valido.activo = "no"
              #Retornar disponibilidad y eliminar la venta de la tabla de quinielas o pale o tripletas etc..
            #  @retornar = retornar_disponibilidad_y_eliminar_venta(@t_valido)


              #if (@t_valido.save && @retornar)
              if (@t_valido.save)
                @monto_tk = Jugadalot.where(:ticket => @t_valido).last.monto
                redirect_to "/jugadalots/new", notice: "OK. Ticket anulado OK. Ticket: #{@t_valido.id} S/N: #{@t_valido.serial} Monto: $#{@monto_tk}. Favor marcar el ticket como NULO" and return 
              else
                redirect_to "/jugadalots/new", notice: "X. Error al grabar anulacion. Favor intertar de nuevo o llamar a la Central para su anulacion manual." and return                 
              end


              #verificar si se puede anular segun estas condiciones:

              #1- ticket es de esta banca?
              #2- ticket no esta nulo?
              #3- puede anularse? hora permitiada 
              #4- sorteo no esta cerrado para anular?
              #5- fehca del ticket debe ser de hoy y en el sortedo de hoy para anularse

              #** de lo contrarionticket no puede ser anulado. Atte. Central.

             # anular_ticket(@ticket_anular , @serial_anular)

              redirect_to "/jugadalots/new", notice: "Procesar aqui anulacion del ticket: #{@ticket_anular} y serial: #{@serial_anular} ..ok. " and return 
               #sleep 5 

              
         when /^\/ct\d+\+\d+$/   # Consultar ticket "/at123456+8855522": ganador (pendiente de pago), ganador (pago), nulo. perdedor, en proceso de resultados para procesar.

              @dataframe = entrada.split("+")
              @ticket = @dataframe[0].to_s[3..(@dataframe[0].size-1)]
              @serial = @dataframe[1]

              if  @serial.to_s == "000" # no se necesita serial original si la Central lo consulta con /ctsn+0000 ok
                  @t_valido = Ticket.where(:id => @ticket).first
              else
                 #ticket existe con informacion suministrada?
                 @t_valido = Ticket.where(:id => @ticket , :serial => @serial).first
              end

              if not @t_valido
                redirect_to "/jugadalots/new", notice: "X No se pudo consultar este ticket. Ticket o Serial invalido. Favor verificar. " and return 
              end 

              #verificar si este ticket fue impreso o es un tk virtual no impreso, en este caso no aplica para consulta gadadores o demas, redireccionar ok
              @ticket_fue_impreso = Ticket.where(:id => @ticket , :serial => @serial).first || nil
              if @ticket_fue_impreso.fechaimpresion == nil
                redirect_to "/jugadalots/new", notice: "X Ticket No valido, random /ct ok." and return 
              end

              #verificar si este ticket tiene jugadas, esto porque en tkconsultado details puede no tener jugadas, por tanto el ticket a consultar no tiene jugadas ok, esto pasa en new session tk ok ted
              @tiene_jugadas_validas = Jugadalot.where(:ticket_id => @ticket_id)
              if not @tiene_jugadas_validas
                redirect_to "/jugadalots/new", notice: "X No tiene jugadas validas para consultar." and return 
              end


              @activo =  @t_valido.activo.nil? ?  "PDTE." : @t_valido.activo.to_s
              @ganador =  @t_valido.ganador.nil? ? "PDTE." : @t_valido.ganador.to_s
              @pagotk =     @t_valido.pago.nil? ?  "PDTE." :  @t_valido.pago.to_s # pago real es el del ticket de gallos
              @sucursal =  @t_valido.user.sucursalbt
              @fecha_impresion = @t_valido.fechaimpresion.to_s # Sera mostrado en la vista ok varibale global
              @parlay_tk_consultado =  @t_valido.parlay # Sera mostrado en la vista ok ted varibale global

              @st =  @mensaje_pago = "" # Declarada para que  no sean nil. ok ted. 

              if @t_valido.ganador == "si"
                #@total_pagar = Ticketsganadorest.where(:ticket_id => @t_valido.id).sum(:montoacobrar)
                @total_pagar = Ticket.where(:id => @t_valido.id).first.pagoreal #pago real del ticket after procesado.

                @st = "Total: $".upcase  + ActionController::Base.helpers.number_to_currency(@total_pagar.to_s, :unit => "", :delimiter => ",", :precision => 0, :separator => ".") 
                
                if (@t_valido.pago == nil || @t_valido.pago == "no" || @t_valido.pago == "") # si es ganador pero no se ha pagado... ok
                  @mensaje_pago = "Para pagar el ticket DEBE digitar /pt#{@t_valido.id}+serial"
                end

              end

              

              #computar info en session_details_tkConsultados
              #@st_detalles = "mostrar_detalles"
              #@detalle_jugadas_ticket_consultado = Jugadalot.where(:ticket_id => @t_valido.id)

              #@tk_detallado = []

              #@detalle_jugadas_ticket_consultado.each do |jugadas|
              #end

             # @resultados_notice = "Es Ganador?: [ #{@ganador.upcase} ], Pago: [ #{@pago.upcase} " + @st +  " ], Activo: #{@activo.upcase}, Suc.: #{@sucursal}." + " " + @mensaje_pago
             # redirect_to "/jugadalots/new", notice: "Es Ganador?: [ #{@ganador.upcase} ], Pago: [ #{@pago.upcase} " + @st +  " ], Activo: #{@activo.upcase}, Suc.: #{@sucursal}." + " " + @mensaje_pago and return 
              #redirect_to "/jugadalots/new" and return # muestra la vista del controllador
              session[:tk_consultado_id] = @t_valido.id
              redirect_to "/tkconsultado" and return               

         #/pt321+4068295371
         when /^\/pt\d+\+\d+$/  # /pt pago de ticket. ej.  /pt321+4068295371 (pagar ticket + serail)
              @dataframe = entrada.split("+")
              @ticket = @dataframe[0].to_s[3..(@dataframe[0].size-1)]
              @serial = @dataframe[1]

              #ticket existe con informacion suministrada?
              @t_valido = Ticket.where(:id => @ticket , :serial => @serial).first

              if not @t_valido
                redirect_to "/jugadalots/new", notice: "X No se pudo encontrar este ticket para fines de pago. Ticket o Serial invalido. Favor verificar nuevamente " and return 
              end 

              if (@t_valido.pago == "si")
                redirect_to "/jugadalots/new", notice: "Este ticket ya fue pagado. Ticket pagado por: #{@t_valido.pagadopor}. Favor conserve el ticket y contacte a la central." and return                   
              end


              if (@t_valido.activo == "si" && @t_valido.ganador == "si" && ( @t_valido.pago == "no" || @t_valido.pago == nil || @t_valido.pago == "" ) )
                  #Si entra a este bloque es porque es ganador y no esta pago. Antes de pagarlo verificar que este ticket no tenga jugadas en algun sorteo abierto aun. (Si se paga este ticket asi, entonces no se prodra registrar el pago de las demas jugadas ganadoras de los demas sorteos.ok ted.) Debe esperar los demas sorteos jugados en este ticket para procesar su pago. En otra ocasion que juegue tickets por separados si no desea esperar los demas recultado para su cobro, ya que con el pago se retiene el ticket y los demas sorteos abiertos si hay jugadas ganadoras luego compromenten el cuadre de pagos de tickets y demas. Debe esperar que cierren todos los sorteos jugados en ese ticket o realizar varios ticket independiente en la proxima(Todas las jugadas en un solo ticket o en varios por separado segun lo desee el cliente). ok ted.
                  
                 @peleas_abiertas = verifcar_alguna_pelea_abierta_antes_pago_any_ticket(@t_valido)
                  
                  if  @peleas_abiertas
                      @peleas_abiertas = @peleas_abiertas.join(",")
                      redirect_to "/jugadalots/new", notice: "X - Este ticket aun tiene peleas abierta: [ #{@peleas_abiertas} ].Debe esperar los resultados de los mismos. " and return                       
                  end

                  
                  #Si todo ok, procesar el pago:  
                  
                  @t_valido.pago = "si"
                  @t_valido.pagadopor = current_user.email
                  @t_valido.save
                  @total_pagar = Ticket.where(:id => @t_valido.id).first.pagoreal #pago real del ticket after procesado.
                  redirect_to "/jugadalots/new", notice: "Ticket pagado correctamente ($#{@total_pagar} pesos). Favor guardar el ticket pagado como constancia." and return                   
              end

               if (@t_valido.activo != "si")
                redirect_to "/jugadalots/new", notice: "Este ticket no puede ser pagado porque es nulo o no esta activo en el sistema. Favor contactar central." and return                   
               end

              redirect_to "/jugadalots/new", notice: "No se pudo procesar este pago. Favor intentar nuevamente o contacte la central." and return 

        
         else # Este else es del condicional case (En caso de que case entrada no cumpla, else no se entiende la jugada. Esto no deja que el codigo siga hacia abajo. ok ted. es como el break o return de este controlador en esta parte de la logica implementada...)

          redirect_to "/jugadalots/new", notice: "NO SE ENTIENDE ESTA JUGADA:  #{entrada}, FAVOR REVISAR FORMATO NUEVAMENTE" and return 
        
      end # este es el end del case.

    end # este end es del entrada.each do |jugada| ok ted.

    redirect_to "/jugadalots/new", notice: "Pocesado Ok." and return 

  end # fin de la accion create.

  # PATCH/PUT /jugadalots/1
  # PATCH/PUT /jugadalots/1.json
  def update

    redirect_to "/jugadalots/new", notice: "NO PERMITIDO UPDATE." and return 

    respond_to do |format|
      if @jugadalot.update(jugadalot_params)
        format.html { redirect_to @jugadalot, notice: 'Jugadalot was successfully updated.' }
        format.json { render :show, status: :ok, location: @jugadalot }
      else
        format.html { render :edit }
        format.json { render json: @jugadalot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jugadalots/1
  # DELETE /jugadalots/1.json
  def destroy
    @jugadalot.destroy
    respond_to do |format|
      format.html { redirect_to new_jugadalot_path }
      format.json { head :no_content }
    end
  end


  def tkconsultado
    #obtener el id desde la session y consultar detalles sobre el ticket:
    @ticket_id = session[:tk_consultado_id] 
    @detalle_jugadas_ticket_consultado = Jugadalot.where(:ticket_id => @ticket_id)
    @monto_tk = @detalle_jugadas_ticket_consultado.last.monto # Jugadalot last monto ok
    @posible_pago_tk = @detalle_jugadas_ticket_consultado.last.posiblepago # Jugadalot last monto ok
    
     @jugadalots = @detalle_jugadas_ticket_consultado

    @t_valido =  Ticket.find(@ticket_id)

    @activo =  @t_valido.activo.nil? ?  "PDTE." : @t_valido.activo.to_s
    @ganador =  @t_valido.ganador.nil? ? "PDTE." : @t_valido.ganador.to_s
    @pago =  @t_valido.pago.nil? ?  "PDTE." : @t_valido.pago.to_s # pago real es el del ticket de gallos
    @sucursal =  @t_valido.user.sucursalbt
    @fecha_impresion = @t_valido.fechaimpresion.to_s # Sera mostrado en la vista ok varibale global
    @parlay_tk_consultado =  @t_valido.parlay # Sera mostrado en la vista ok ted varibale global

    @st =  @mensaje_pago = "" # Declarada para que  no sean nil. ok ted. 

    if @t_valido.ganador == "si"
      #@total_pagar = Ticketsganadorest.where(:ticket_id => @t_valido.id).sum(:montoacobrar)
      @total_pagar = Ticket.where(:id => @t_valido.id).first.pagoreal #pago real del ticket after procesado.

      @st = "Pago Total: $".upcase  + ActionController::Base.helpers.number_to_currency(@total_pagar.to_s, :unit => "", :delimiter => ",", :precision => 0, :separator => ".") 
      
      if (@t_valido.pago == nil || @t_valido.pago == "no" || @t_valido.pago == "") # si es ganador pero no se ha pagado... ok
        @mensaje_pago = "Para pagar el ticket DEBE digitar /pt#{@t_valido.id}+serial"
      end

    end

    if @pago.to_s == "si"
      @pago = @pago.to_s + ", ESTE TICKET YA FUE PAGADO !!! "  
    end

    #computar info en session_details_tkConsultados
    #@st_detalles = "mostrar_detalles"
    
    @noticia =  "Es Ganador?: [ #{@ganador.upcase} ], Pago: [ #{@pago.upcase} " + @st +  " ], Activo: #{@activo.upcase}, Suc.: #{@sucursal}." + " " + @mensaje_pago


    
  end

  


  #DEFINICION DE FUNCIONES PRIVADAS:

  private


  def parlay_count_name # retorna el nombre del parlay en base a la cant de jugadas que tiene un ticket ok
     parlay_count = Jugadalot.where(:ticket_id => last_tickect_current_user).count

    tipo_jugada = "n/a" # valor default
    

    if parlay_count.to_i == 1
      tipo_jugada = "directo" 
    end

    if parlay_count.to_i == 2
      tipo_jugada = "pale" 
    end

    if parlay_count.to_i == 3
      tipo_jugada = "tripleta" 
    end

    if parlay_count.to_i == 4
      tipo_jugada = "cuarteta" 
    end

    if parlay_count.to_i == 5
      tipo_jugada = "quinteta" 
    end

    if parlay_count.to_i == 6
      tipo_jugada = "sexteta" 
    end

    if parlay_count.to_i == 7
      tipo_jugada = "septimeta" 
    end

    if parlay_count.to_i == 8
      tipo_jugada = "octaveta" 
    end

    tipo_jugada
  end # fin de la funcion, retorna lo ultimo evaluado bien ok.



  def excede_control_de_pago_x_ticket(last_tickect_current_user, entrada)
    #verificar tipo de parlay de ese ticket:
    parlay_count = Jugadalot.where(:ticket_id => last_tickect_current_user).count
    #parlay_count

    #switch case para asignar tipo de jugada segun tipo de parlay para buscar en control de pago:
    tipo_jugada = "default" # valor vacio para posible uso fuera de contexto de  septimetas en adelante, hacer que retorne false la funcion ok. (no encontrado)
    
    #el switch case lo haremos de modo simple con el if statement por ahora ok:
    if parlay_count.to_i == 1
      tipo_jugada = "directo" 
    end

    if parlay_count.to_i == 2
      tipo_jugada = "pale" 
    end

    if parlay_count.to_i == 3
      tipo_jugada = "tripleta" 
    end

    if parlay_count.to_i == 4
      tipo_jugada = "cuarteta" 
    end

    if parlay_count.to_i == 5
      tipo_jugada = "quinteta" 
    end

    if parlay_count.to_i == 6
      tipo_jugada = "sexteta" 
    end

    if parlay_count.to_i == 7
      tipo_jugada = "septimeta" 
    end

    if parlay_count.to_i == 8
      tipo_jugada = "octaveta" 
    end

    control_monto_max_pago = Controldepagogt.where(:tipojugada => tipo_jugada ).first.limitexticket.to_i

    #verificar posible pago: riesgo
    entrada = entrada[1..(entrada.size-1)] # "SOBREESCRIBO ESTO ASI: ..250 => .250" ESTO PARA QUE LUEGO SE TRANSFORME DE .250 A 250 DENTRO DE LA FUNCION. REUCUERDA QUE EN ESTA SECCION DE CODIGO ENTRADA DE DE COBRO FINAL NO DE EVALUACION DE PAGO: ..250 ES DE COBRO FINAL. OK. TED.
    riesgo = procesar_posible_pago(last_tickect_current_user, entrada)# procesar_posible_pago retorna array ok ted.

    if (riesgo != nil) # esto para evitar errores de nil. ya no necesario porue depuramos no jugadas vacias para computar pero lo dejaremos ok. ted
      if (riesgo[1].to_i <= control_monto_max_pago)
        false # no excede ok
      else
        true # execede
      end
    end

  end # fin de la funcion excede_control_de_pago_x_ticket





  def excede_control_de_pago_x_ticket_x_parlay(last_tickect_current_user, entrada) # define el monto maximo a sacar por parlay, ej. pago max para tripletas, cuartetas etc.. no por ticket sino por tipo de ticket parlay ok
    @sumatoria_posible_pago_todos_tickets_de_hoy_ese_parlay = 0 # inicializacion de variable de sumatoria en cero ok.
    #verificar tipo de parlay de ese ticket:
    parlay_count = Jugadalot.where(:ticket_id => last_tickect_current_user).count
    #parlay_count

    #switch case para asignar tipo de jugada segun tipo de parlay para buscar en control de pago:
    tipo_jugada = "default" # valor vacio para posible uso fuera de contexto de  septimetas en adelante, hacer que retorne false la funcion ok. (no encontrado)
    
    #el switch case lo haremos de modo simple con el if statement por ahora ok:
    if parlay_count.to_i == 1
      tipo_jugada = "directo" 
    end

    if parlay_count.to_i == 2
      tipo_jugada = "pale" 
    end

    if parlay_count.to_i == 3
      tipo_jugada = "tripleta" 
    end

    if parlay_count.to_i == 4
      tipo_jugada = "cuarteta" 
    end

    if parlay_count.to_i == 5
      tipo_jugada = "quinteta" 
    end

    if parlay_count.to_i == 6
      tipo_jugada = "sexteta" 
    end

    if parlay_count.to_i == 7
      tipo_jugada = "septimeta" 
    end

    if parlay_count.to_i == 8
      tipo_jugada = "octaveta" 
    end

    control_monto_max_pago = Controldepagogt.where(:tipojugada => tipo_jugada ).first.limiteglobal.to_i

    #acabo de conseguir el limite global de ese parlay en curso, ahora buscar la sumatoria de todos las jugadalots.posiblepago de los ticket activo de hoy y ver si no sbobrepara ese limiet ok
    t_ids = Ticket.today.where(:activo => "si", :parlay => tipo_jugada.to_s ).ids # todos los ticket actio de hoy con ese parlay ok
     
     @listado_jugadas_a_sumar = Jugadalot.where(:ticket_id => t_ids)# POstgres casting sum string error ok..sum(:posiblepago).to_i
     
     if not @listado_jugadas_a_sumar.nil?
      @listado_jugadas_a_sumar.each do |jugada|
         @sumatoria_posible_pago_todos_tickets_de_hoy_ese_parlay += jugada.posiblepago.to_i
      end
     end

     

    #Sumar posible pago de esas jugadas de cada ticket parlay ok.
    #@sumatoria_posible_pago_todos_tickets_de_hoy_ese_parlay = 0
    #t.each do |ticket|
    # @sumatoria_posible_pago_todos_tickets_de_hoy_ese_parlay  += Jugadalot.where(:ticket_id => ticket.id).last.posiblepago.to_i
    #end

    if @sumatoria_posible_pago_todos_tickets_de_hoy_ese_parlay.to_i <= control_monto_max_pago.to_i
      # si es menor todo ok
      false # no excede
    else
      true #si excede  
    end


  end # fin de la funcion excede_control_de_pago_x_ticket_x_parlay








#Ticket.today.where(:activo =>"si").last


  def excede_control_de_pago_global()
    @sumatoria_posible_pago_todos_tickets_de_hoy_todos_parlay_global = 0 # inicializacionn de variable sumatoria en cero ok
    #La idea aqui es verificar si la sumatoria de posible pago de todas las jugadas de todos los tipos de tickets activos de hoy no excede el limite globar de riesgo del sistema ok
        
    #limite GLOBAL = 1 ADMINISTRATIVO OK Y TIPOJUGADA TAMBIEN MANUAL = GLOBAL OK TED. POPULATE IT IN DATABASE PRODUCTION OK:
    control_monto_max_pago_global = Controldepagogt.where(:tipojugada => "global" ).first.limiteglobal.to_i || 1 # setear un valor default ok 

    t_ids = Ticket.today.where(:activo => "si").ids # todos los ticket actio de hoy con ese parlay ok
    
     @listado_sumatoria_posible_pago =  Jugadalot.where(:ticket_id => t_ids)# postrges casting erro string ok .sum(:posiblepago).to_i
     
     if not @listado_sumatoria_posible_pago.nil?
        @listado_sumatoria_posible_pago.each do |jugada|
          @sumatoria_posible_pago_todos_tickets_de_hoy_todos_parlay_global += jugada.posiblepago.to_i
        end
       
     end
     
     
    #Sumar posible pago de esas jugadas de cada ticket parlay ok.
#    @sumatoria_posible_pago_todos_tickets_de_hoy_todos_parlay_global = 0
#    t.each do |ticket|
#     @sumatoria_posible_pago_todos_tickets_de_hoy_todos_parlay_global  += Jugadalot.where(:ticket_id => ticket.id).last.posiblepago.to_i
#    end

    if @sumatoria_posible_pago_todos_tickets_de_hoy_todos_parlay_global.to_i <= control_monto_max_pago_global.to_i
      # si es menor todo ok
      false # no excede
    else
      true #si excede  
    end


  end # fin de la funcion excede_control_de_pago_global





  def suma_posible_pago_parlay(parlay_count)
    tickets = Ticket.today.ids 
    jugadas = 0 # por sicaso. inicializacion de variable de sumatoria en cero ok.

    listado_a_sumar = Ticket.today.where(:parlay => parlay_count)# postgres error casting sum string ok .sum(:pagoreal)
    if not listado_a_sumar.nil?
      listado_a_sumar.each do |ticket|
        jugadas += ticket.pagoreal
      end 
    end
    
    jugadas  #retorna el valor de jugadas ok.

  end


  def verifcar_alguna_pelea_cerrada ticket
    @jugadalots = Jugadalot.where(:ticket_id => ticket.id).today # todas pero de hoy.
    @alguna_pelea_cerrada = false
    @peleas_cerrada = [] # listado de peleas cerradas array

     @jugadalots.each do |jugada|
       
       linea_pelea  = Lineat.where(:pelea => jugada.pelea.to_i).today.first   || [] # 
       if linea_pelea.status == "cerrada"
         @peleas_cerrada << linea_pelea.pelea # 3, 4 etc cerradas
       end
       
      end

      if @peleas_cerrada.empty? # si esta vacio no hay niguna pelea cerrada
          return false 
        else
          return @peleas_cerrada # retorna las peleas cerradas (array con informacion) => 'true'      
      end  


  end #fin de la funcion verifcar_alguna_pelea_cerrada



  def verifcar_alguna_pelea_abierta_antes_pago_any_ticket (ticket)
    #todas peleas cerrada implica cero peleas abiertas ok.

    @jugadalots = Jugadalot.where(:ticket_id => ticket.id) # todas las jugadas de ese ticket
    @alguna_pelea_abierta = false
    @peleas_abierta = [] # listado de peleas cerradas array

     @jugadalots.each do |jugada|
       
       #verifcar que todas las jugadas de ese ticket esten cerrada (peleas cerradas de ese ticket de esa fecha de esa lina de ese dia ok)
       linea_pelea  = Lineat.by_day(jugada.created_at.to_date).where(:pelea => jugada.pelea.to_i).first   || [] # 
       if linea_pelea.status == "abierta"
         @peleas_abierta << linea_pelea.pelea # 3, 4 etc cerradas
       end
       
      end

      if @peleas_abierta.empty? # si esta vacio no hay niguna pelea cerrada
          return false 
        else
          return @peleas_abierta # retorna las peleas abiertas
      end  


  end #fin de la funcion verifcar_alguna_peleaabierta 





  def procesar_posible_pago(jugadalot, entrada)
    entrada = entrada[1..(entrada.size-1)] # ".250 => 250" ok sacar monto apostado ok.
    apostado = entrada.to_f
    
    jugadas  =  Jugadalot.where(:ticket_id => jugadalot) || []
    
    if (jugadas == []) # esto es posible en rails probado ok. Si no hay jugadas returnal nil para que envie mensaje de realizar jugadas primero ok  ted. Ver la logica del progrma que invoca esta funcion ok.
      return nil 

    else
        #Hay jugadas para procesar la formula del parlay de posible pago ok:\
        #ganancia = apostado * [coeficiente_jugada_parley_1] * [coeficiente_jugada_parley_2] * [coeficiente_jugada_parley_n] - apostado
        coeficiente_jugada_parley = []
        
        jugadas.each do |jugada|
          b = jugada.ml.to_s
          if( b[0] == "-" )# < 0 # -125 mando gavela macho, -110, -170
            coeficiente = (1.to_f + (100.to_f / b.to_f.abs)).to_f.round(4) # trabajar a 4 cifras decimales.
          else
            coeficiente = (1.to_f + ((b.to_f.abs) / 100.to_f)).to_f.round(4) # trabajar a 4 cifras decimales.
          end
          #puts coeficiente
          #debugger
          coeficiente_jugada_parley << coeficiente.to_f.round(4)
        end

        #multiplicar los elementos del array para obtener el coeficiente resultante
        #setear algunos casting primero, de string a int para multiplicar con inject
        #coeficiente_jugada_parley.map!(&:to_f) #inject(:*).round(4)
       # coeficiente_resultante = coeficiente_jugada_parley.inject(:*).round(4) # multiplica todos los elementos del array #sacado link:https://stackoverflow.com/questions/7050869/ruby-multiply-all-elements-of-an-array 
        
        
        resultante_multiplicar = 1.to_f # 1 es el elemento neutro de la multiplicacion ok ted.
        
        coeficiente_jugada_parley.each do |coeficiente|
          resultante_multiplicar = (resultante_multiplicar.to_f * coeficiente.to_f.round(4)).round(4)
        end
        
        coeficiente_resultante = resultante_multiplicar.to_f.round(4)

        ganacia = ( (apostado.to_f * coeficiente_resultante.to_f) - apostado.to_f).to_i
        #ganacia = 18
        acobrar = (apostado + ganacia).to_i
        #lo de abajo comentado es para debug only ok. ted.
        #return apostado, "#{ganacia}, ticketid:#{jugadalot}, ticketlines: #{jugadas.all.count}, apostado:#{apostado}, coeficiente:#{coeficiente_resultante}, aray:#{coeficiente_jugada_parley.join("|")}, jugadas: #{jugadas.all.count}", acobrar
        return apostado.to_i, ganacia, acobrar

    end # fin del if else end block ok
    

  end


  def verificar_jugadas_repetidas jugadalot
    #jugadalot es un object param
    # 4 tipos de jugadas: 0101, 0102, 0103, 0104
    jugadas  =  Jugadalot.where(:ticket_id => jugadalot.ticket_id) || [] # nil en caso de no encontrar jugadas de ese ticket_id, my remoto pero contemplarlo.    
    
    comandos = []
    comandos << jugadalot.comandojugada  # incluyo tambien la ultima jugada digitada en pantalla que aun no esta en la consulta del modelo. Esta jugada viene dentro del objeto recibido como param ok.

    jugadas.each do |jugada|
     comandos << jugada.comandojugada # capturar todos los comandos de las jugadas
    end
    
    if (comandos.size != comandos.uniq.size )
      return true # se eliminaron reperidos por tanto hay diferencias. ok ted.
    else
      return false # no hay cambios del size del array por tanto no se eliminaron comandos repetidos. ok. esto evita el mismo tipo de apuesta dos veces. ok.
    end
        
  end # fin de la funcion verificar_jugadas_repetidas


  def verificar_jugadas_contradictorias jugadalot
    #jugadalot es un object param
    # 4 tipos de jugadas: 0101, 0102, 0103, 0104
    jugadas  =  Jugadalot.where(:ticket_id => jugadalot.ticket_id) || [] # nil en caso de no encontrar jugadas de ese ticket_id, my remoto pero contemplarlo.    
    respuesta = false

    comandos = []
    comando_actual = jugadalot.comandojugada  # incluyo tambien la ultima jugada digitada en pantalla que aun no esta en la consulta del modelo. Esta jugada viene dentro del objeto recibido como param ok.

    jugadas.each do |jugada|
     comandos << jugada.comandojugada # capturar todos los comandos de las jugadas
    end
    #aplicar la logica de las jugadas contradictorias
    #la jugada contradictoria se verifica en cada entrada nueva, compara la que llega con las que estan?

    #si la jugada nueva es al cinta azul, verificar que no este esa misma pelea al cinta blanca y viceversa
    # comando_actual => "0101" por ejemplo
    if comando_actual[2..3] == "01" # pelea apostando al cinta azul
      jugada_opuesta = comando_actual[0..1].to_s + "0"+"2" #misma pelea pero al cinta blanca
      return comandos.include?(jugada_opuesta.to_s)
    end

    if comando_actual[2..3] == "02" # pelea apostando al cinta azul
      jugada_opuesta = comando_actual[0..1].to_s + "0"+"1" #misma pelea pero al cinta blanca
      return comandos.include?(jugada_opuesta.to_s)
    end

    if comando_actual[2..3] == "03" # pelea apostando al cinta azul
      jugada_opuesta = comando_actual[0..1].to_s + "0"+"4" #misma pelea pero al cinta blanca
      return comandos.include?(jugada_opuesta.to_s)
    end

    if comando_actual[2..3] == "04" # pelea apostando al cinta azul
      jugada_opuesta = comando_actual[0..1].to_s + "0"+"3" #misma pelea pero al cinta blanca
      return comandos.include?(jugada_opuesta.to_s)
    end
    
  end # fin del metodo verificar_jugadas_contradictorias


  def cargar_comandos_jugadas_repetir_otro_sorteo(ticket, sorteo_origen , sorteo_destino)
          #Buscar todos los comandos de todas las jugadaslots de ese ticket con ese sorteo de origen.
          @array_jugadas_de_ese_sorteo_en_ese_ticket =  Jugadalot.where(:ticket_id => ticket, :sorteot => Sorteot.where(:sigla => sorteo_origen.to_s).first.id)
          
          @comando_jugadas =[] # Defino el array que trenda todos los comando de las jugadas de este sorteo de ese ticket

          @array_jugadas_de_ese_sorteo_en_ese_ticket.each do |jugadalot|
            @comando_jugadas << jugadalot.comandojugada
          end
      
          #Hacer un solo string con todos los comando_jugadas.join("*") unidos por caracter especial "*" ok. ted.
          @comando_jugadas = @comando_jugadas.join("*")

          #Hacer un string.replace pattern .01 a .02 (sorteo_origen, sorteo_destino)
          sorteo_origen  = "." + sorteo_origen
          sorteo_destino = "." + sorteo_destino

          @comando_jugadas.gsub(sorteo_origen, sorteo_destino)
          #dejar que siga evaluando hacia abajo... ok ted. Bloque de codigo guardar jugadas.
    
  end



  def verifcar_algun_sorteo_cerrado ticket
    #retorna un array con los sorteos cerrados. Y false si esta vacio (No hay cerraoos)


      @jugadalots = Jugadalot.where(:ticket_id => ticket.id) # todos.
      @sorteos = []
      @hash_horarios = {}
      @sorteos_cerrados = []
#sort
#sacar cada dia en array value hashes
      @jugadalots.each do |jugada|
        @sorteos << jugada.sorteot.id # consigo el id de todos los sorteos de ese ticket
       # jugada.sorteot.horariosorteot.where(:)

      end

      @sorteos.sort! #organizo ids sorteos de menor a mayor y elimino ids repetidos.
      @sorteos.uniq! # debo hacerlo separado porque array.sort.uniq! no lo guarda de una vez

      @sorteos.each do |sorteo_id|
        sorteo= Sorteot.find_by_id(sorteo_id)

        @hash_horarios["0"] = sorteo.horariosorteot.domingo.strftime("%H%M%S").to_i # El Domingo retorda wday => 0. ok ted.
        @hash_horarios["1"] = sorteo.horariosorteot.lunes.strftime("%H%M%S").to_i
        @hash_horarios["2"] = sorteo.horariosorteot.martes.strftime("%H%M%S").to_i
        @hash_horarios["3"] = sorteo.horariosorteot.miercoles.strftime("%H%M%S").to_i
        @hash_horarios["4"] = sorteo.horariosorteot.jueves.strftime("%H%M%S").to_i
        @hash_horarios["5"] = sorteo.horariosorteot.viernes.strftime("%H%M%S").to_i
        @hash_horarios["6"] = sorteo.horariosorteot.sabado.strftime("%H%M%S").to_i

       

       if (Time.now.strftime("%H%M%S").to_i >  @hash_horarios[Time.now.wday.to_s]) || sorteo.abierto != 'si' || sorteo.activo != 'si' # Que nadie anule ticket si hay cierre del sorteo por la hora, por razon manual administrativa, etcc.. no se permite anular ticket de sorteos ya cerrados.
          @sorteos_cerrados << sorteo.nombre.to_s + " - (Cerrado)."
       end # end del if

      end # end del bloque each

      if @sorteos_cerrados.empty? # si esta vacio no hay nigun sorteo cerrado.
          return false 
        else
          return @sorteos_cerrados # retorna los sorteos cerrados (array con informacion) => 'true'      
      end    

  end # fin de la funcion de verificar sorteos cerrados

  



  def  retornar_disponibilidad_y_eliminar_venta ticket
    @jugadalots = Jugadalot.where(:ticket_id => ticket.id) 
    result = 0   

    @jugadalots.each do |jugadalot|

      if jugadalot.qpt == 'Q' # && jugadalot.sorteot.sigla == '01' # Verificar Disponibilidad de Quiniela de la Nacional Noche
        
        @modelocontrolq = Aliasmodelosiglasorteot.where(:siglasorteo => jugadalot.sorteot.sigla).first.modelocontrolq  
        @modelocontrolq = @modelocontrolq.capitalize.classify.constantize # Esto para convertir string en constante y poder acceder al modelos de Active Record. Scado de este link: https://stackoverflow.com/questions/34757582/using-variables-for-model-names-in-active-record      
  
        @modeloventaq = Aliasmodelosiglasorteot.where(:siglasorteo => jugadalot.sorteot.sigla).first.modeloventaq  
        @modeloventaq = @modeloventaq.capitalize.classify.constantize # Esto para convertir string en constante y poder acceder al modelos de Active Record. Scado de este link: https://stackoverflow.com/questions/34757582/using-variables-for-model-names-in-active-record      
  

        #Actualizar disponibilidad y registrar venta
        @act_disp = @modelocontrolq.where(:numero => jugadalot.n1.to_i).first
        @act_disp.vendida -= jugadalot.monto.to_i # devuelto valor de disponibilidad usado.
      
        @eliminar_ventas = @modeloventaq.where(:ticket_id => ticket.id) # => arreglo con todas las jugadas quiunielas de ese ticket anulado, hay que borrarlas todas. 
        
        @eliminar_ventas.each do |jugada|
          jugada.destroy
        end

        if (@act_disp.save &&  @eliminar_ventas) == false
         result +=1
        end

      end


      if jugadalot.qpt == 'P' # && jugadalot.sorteot.sigla == '01' # Verificar Disponibilidad de Quiniela de la Nacional Noche
        
        @modelocontrolp = Aliasmodelosiglasorteot.where(:siglasorteo => jugadalot.sorteot.sigla).first.modelocontrolp  
        @modelocontrolp = @modelocontrolp.capitalize.classify.constantize # Esto para convertir string en constante y poder acceder al modelos de Active Record. Scado de este link: https://stackoverflow.com/questions/34757582/using-variables-for-model-names-in-active-record      
  
        @modeloventap = Aliasmodelosiglasorteot.where(:siglasorteo => jugadalot.sorteot.sigla).first.modeloventap  
        @modeloventap = @modeloventap.capitalize.classify.constantize # Esto para convertir string en constante y poder acceder al modelos de Active Record. Scado de este link: https://stackoverflow.com/questions/34757582/using-variables-for-model-names-in-active-record      


        #Actualizar disponibilidad y registrar venta
        @act_disp =  @modelocontrolp.where(:n1 => jugadalot.n1.to_i , :n2 => jugadalot.n2.to_i).first
        @act_disp.vendida -= jugadalot.monto.to_i # devuelto valor de disponibilidad usado.
      
        @eliminar_ventas = @modeloventap.where(:ticket_id => ticket.id) # => arreglo con todas las jugadas quiunielas de ese ticket anulado, hay que borrarlas todas. 
        
        @eliminar_ventas.each do |jugada|
          jugada.destroy
        end

        if (@act_disp.save &&  @eliminar_ventas) == false
         result +=1
        end

      end

      if jugadalot.qpt == 'T' # && jugadalot.sorteot.sigla == '01' # Verificar Disponibilidad de Quiniela de la Nacional Noche
        

        @modelocontrolt = Aliasmodelosiglasorteot.where(:siglasorteo => jugadalot.sorteot.sigla).first.modelocontrolt  
        @modelocontrolt = @modelocontrolt.capitalize.classify.constantize # Esto para convertir string en constante y poder acceder al modelos de Active Record. Scado de este link: https://stackoverflow.com/questions/34757582/using-variables-for-model-names-in-active-record      
  
        @modeloventat = Aliasmodelosiglasorteot.where(:siglasorteo => jugadalot.sorteot.sigla).first.modeloventat  
        @modeloventat = @modeloventat.capitalize.classify.constantize # Esto para convertir string en constante y poder acceder al modelos de Active Record. Scado de este link: https://stackoverflow.com/questions/34757582/using-variables-for-model-names-in-active-record      

        #Actualizar disponibilidad y registrar venta
        @act_disp = @modelocontrolt.where(:n1 => jugadalot.n1.to_i , :n2 => jugadalot.n2.to_i  , :n3 => jugadalot.n3.to_i).first
        @act_disp.vendida -= jugadalot.monto.to_i # devuelto valor de disponibilidad usado.
      
        @eliminar_ventas = @modeloventat.where(:ticket_id => ticket.id) # => arreglo con todas las jugadas quiunielas de ese ticket anulado, hay que borrarlas todas. 
        
        @eliminar_ventas.each do |jugada|
          jugada.destroy
        end

        if (@act_disp.save &&  @eliminar_ventas) == false
         result +=1
        end

      end

    end # end del each loop

    if result > 0
      return false
    else
      return true # todo ok. Disponibilidad descontada y venta registrada en tabla.
    end

  end



  def descontar_disponibilidad_y_registrar_venta ticket
    @jugadalots = Jugadalot.where(:ticket_id => ticket.id) 
    result = 0   
    
    @jugadalots.each do |jugadalot|
      
      if jugadalot.qpt == 'Q' #&& jugadalot.sorteot.sigla == '01' # Verificar Disponibilidad de Quiniela de la Nacional Noche
        
         # Todo va aqui mismo (lo del alias modelo. ok ted.)
        @modelocontrolq = Aliasmodelosiglasorteot.where(:siglasorteo => jugadalot.sorteot.sigla).first.modelocontrolq  
        @modelocontrolq = @modelocontrolq.capitalize.classify.constantize # Esto para convertir string en constante y poder acceder al modelos de Active Record. Scado de este link: https://stackoverflow.com/questions/34757582/using-variables-for-model-names-in-active-record      
  
        @modeloventaq = Aliasmodelosiglasorteot.where(:siglasorteo => jugadalot.sorteot.sigla).first.modeloventaq  
        @modeloventaq = @modeloventaq.capitalize.classify.constantize # Esto para convertir string en constante y poder acceder al modelos de Active Record. Scado de este link: https://stackoverflow.com/questions/34757582/using-variables-for-model-names-in-active-record      
  

        #Actualizar disponibilidad y registrar venta
        @act_disp = @modelocontrolq.where(:numero => jugadalot.n1.to_i).first
        @act_disp.vendida += jugadalot.monto.to_i
      
        @resgistrar_venta = @modeloventaq.new #where(:numero => jugadalot.n1.to_i).first
        @resgistrar_venta.ticket_id = ticket.id 
        @resgistrar_venta.n1 = jugadalot.n1
        @resgistrar_venta.monto = jugadalot.monto 
      
        if (@act_disp.save && @resgistrar_venta.save) == false
         result +=1
        end

      end

      if jugadalot.qpt == 'P' # && jugadalot.sorteot.sigla == '01' # Verificar Disponibilidad de Quiniela de la Nacional Noche
        
        @modelocontrolp = Aliasmodelosiglasorteot.where(:siglasorteo => jugadalot.sorteot.sigla).first.modelocontrolp  
        @modelocontrolp = @modelocontrolp.capitalize.classify.constantize # Esto para convertir string en constante y poder acceder al modelos de Active Record. Scado de este link: https://stackoverflow.com/questions/34757582/using-variables-for-model-names-in-active-record      
  
        @modeloventap = Aliasmodelosiglasorteot.where(:siglasorteo => jugadalot.sorteot.sigla).first.modeloventap  
        @modeloventap = @modeloventap.capitalize.classify.constantize # Esto para convertir string en constante y poder acceder al modelos de Active Record. Scado de este link: https://stackoverflow.com/questions/34757582/using-variables-for-model-names-in-active-record      

        #Actualizar disponibilidad y registrar venta
        @act_disp = @modelocontrolp.where(:n1 => jugadalot.n1.to_i , :n2 => jugadalot.n2.to_i ).first
        @act_disp.vendida += jugadalot.monto.to_i
      
        @resgistrar_venta = @modeloventap.new #where(:numero => jugadalot.n1.to_i).first
        @resgistrar_venta.ticket_id = ticket.id 
        @resgistrar_venta.n1 = jugadalot.n1
        @resgistrar_venta.n2 = jugadalot.n2
        @resgistrar_venta.siglas = cero_izq_digito(jugadalot.n1.to_i) + "-" + cero_izq_digito(jugadalot.n2.to_i)
        @resgistrar_venta.monto = jugadalot.monto 
      
        if (@act_disp.save && @resgistrar_venta.save) == false
         result +=1
        end

      end

      if jugadalot.qpt == 'T' # && jugadalot.sorteot.sigla == '01' # Verificar Disponibilidad de Quiniela de la Nacional Noche

        @modelocontrolt = Aliasmodelosiglasorteot.where(:siglasorteo => jugadalot.sorteot.sigla).first.modelocontrolt  
        @modelocontrolt = @modelocontrolt.capitalize.classify.constantize # Esto para convertir string en constante y poder acceder al modelos de Active Record. Scado de este link: https://stackoverflow.com/questions/34757582/using-variables-for-model-names-in-active-record      
  
        @modeloventat = Aliasmodelosiglasorteot.where(:siglasorteo => jugadalot.sorteot.sigla).first.modeloventat  
        @modeloventat = @modeloventat.capitalize.classify.constantize # Esto para convertir string en constante y poder acceder al modelos de Active Record. Scado de este link: https://stackoverflow.com/questions/34757582/using-variables-for-model-names-in-active-record      


        #Actualizar disponibilidad y registrar venta
        @act_disp = @modelocontrolt.where(:n1 => jugadalot.n1.to_i , :n2 => jugadalot.n2.to_i , :n3 => jugadalot.n3.to_i ).first
        @act_disp.vendida += jugadalot.monto.to_i
      
        @resgistrar_venta = @modeloventat.new #where(:numero => jugadalot.n1.to_i).first
        @resgistrar_venta.ticket_id = ticket.id 
        @resgistrar_venta.n1 = jugadalot.n1
        @resgistrar_venta.n2 = jugadalot.n2
        @resgistrar_venta.n3 = jugadalot.n3
        @resgistrar_venta.siglas = cero_izq_digito(jugadalot.n1.to_i) + "-" + cero_izq_digito(jugadalot.n2.to_i) + "-" + cero_izq_digito(jugadalot.n3.to_i)
        @resgistrar_venta.monto = jugadalot.monto 
      
        if (@act_disp.save && @resgistrar_venta.save) == false
         result +=1
        end

      end


    end # end del each loop

    if result > 0
      return false
    else
      return true # todo ok. Disponibilidad descontada y venta registrada en tabla.
    end

  end


  def borrar_todo_jugadalots_actual ticket
    @jugadalots = Jugadalot.where(:ticket_id => ticket.id) # todos.
        #msje La jugada x,y ya no tiene esa cantidad disponible. Favor eliminar o hacerla de otra cantidad menor. (fuera de la funcion).
        
        if @jugadalots
            @jugadalots.each do |jugada|
            jugada.destroy
            end
        end
        #sleep 1 # 3 segundos delay. Limepieza ok. Delay quita eficiencia del controllador response ok.

        #if @jugadalots.empty?
        #  session.destroy # sacar el usuario ?
          #Si no hay jugadas a limpiar es porque estan neciando con el comando /bt o Enter pisado. Dar un time delay y litso. Esto para no cargar el rails server de requests no necesarios. Logica.
        #  sleep 3 # 5 segundos delay.
        #end
  end
#------------------------

#def controlQNNt(jugadalot , global_para_imprimir)
#c = Controlqnnt.where(:numero => jugadalot.n1.to_i).first
#if global_para_imprimir == "si"
#c.vendida += jugadalot.monto
#end
#
#@umbral = (c.limite - c.vendida) - jugadalot.monto # retorna la diferencia.  # Disponible = (c.limite - c.vendida) 
#if @umbral >= 0
#c.save #Actualizo vendida en la Bdatos. (aguanta esa cantidad vendida. ok. ted.)
#end
#
#@umbral #Retorna al valor de umbral +/-
#end

# -----------------------

  def controlQxxt(jugadalot)
    
    @modelo = Aliasmodelosiglasorteot.where(:siglasorteo => jugadalot.sorteot.sigla).first.modelocontrolq  
    @modelo = @modelo.capitalize.classify.constantize # Esto para convertir string en constante y poder acceder al modelos de Active Record. Scado de este link: https://stackoverflow.com/questions/34757582/using-variables-for-model-names-in-active-record      
    c = @modelo.where(:numero => jugadalot.n1.to_i).first
    (c.limite - c.vendida) - jugadalot.monto # retorna la diferencia.  # Disponible = (c.limite - c.vendida) 

  end

  def controlPxxt(jugadalot)

    @modelo = Aliasmodelosiglasorteot.where(:siglasorteo => jugadalot.sorteot.sigla).first.modelocontrolp  
    @modelo = @modelo.capitalize.classify.constantize # Esto para convertir string en constante y poder acceder al modelos de Active Record. Scado de este link: https://stackoverflow.com/questions/34757582/using-variables-for-model-names-in-active-record      
    c = @modelo.where(:n1 => jugadalot.n1.to_i , :n2 => jugadalot.n2.to_i  ).first
    (c.limite - c.vendida) - jugadalot.monto # retorna la diferencia.  # Disponible = (c.limite - c.vendida) 

  end

  def controlTxxt(jugadalot)

    @modelo = Aliasmodelosiglasorteot.where(:siglasorteo => jugadalot.sorteot.sigla).first.modelocontrolt  
    @modelo = @modelo.capitalize.classify.constantize # Esto para convertir string en constante y poder acceder al modelos de Active Record. Scado de este link: https://stackoverflow.com/questions/34757582/using-variables-for-model-names-in-active-record      
    c = @modelo.where(:n1 => jugadalot.n1.to_i , :n2 => jugadalot.n2.to_i, :n3 => jugadalot.n2.to_i ).first
    (c.limite - c.vendida) - jugadalot.monto # retorna la diferencia.  # Disponible = (c.limite - c.vendida) 

  end

  def cero_izq_digito numero
    resultado_string = (numero.to_i < 10 )? ("0" + numero.to_s) : numero.to_s
  end


  def verificar_disponibilidad_global ticket
        @jugadalots = Jugadalot.where(:ticket_id => ticket) # todos.
        #aqui estan todas las jugadas de ese ticket, verificar disp global, hay que ver si hay jugadas repetidas, esto para sumarle la monto y poder verficar como una disp simple...        

        @jugadalots.each do |jugada_patron| # id: integer, n1: integer, n2: integer, n3: integer, monto: integer, qpt: string, created_at: datetime, updated_at: datetime, ticket_id: integer, sorteot_id: integer)

            @jugadalots.each do |jugada_global| 
                  if (jugada_patron.id != jugada_global.id) && (jugada_patron.qpt == jugada_global.qpt) && (jugada_patron.n1 == jugada_global.n1) && (jugada_patron.n2 == jugada_global.n2) && (jugada_patron.n3 == jugada_global.n3) && (jugada_patron.sorteot_id == jugada_global.sorteot_id) && (jugada_patron.ticket_id == jugada_global.ticket_id) 
                    jugada_patron.monto += jugada_global.monto
                    jugada_global.id = jugada_patron.id
                 end

              end
        end


        @resultado_disponibilidad_global = []

        @jugadalots.each do |jugada|
           if ( d = verificar_disponibilidad_simple(jugada) ) < 0 # Ya no hay disponibilidad (valor negativo)
            @disponible = jugada.monto.to_i + d.to_i # D es el sobrante negativo. Monto + (-Sobrante ) = Cant. diponible en el sistema.
            @resultado_disponibilidad_global << "** Cantidad ya no esta disponible para la jugada: " + jugada.qpt.to_s + "-> " + jugada.n1.to_s + " $" + jugada.monto.to_s + ". Disp. solo: $ #{@disponible } ** "
           end
        end
        
        @resultado_disponibilidad_global # retorna un array vacio a.nil? o un array con las jugadas ya no disponibles.

  end



  def verificar_disponibilidad_simple jugadalot
    #verificar tipo de jugada QPT
    #verificar sorteo
    #verificar disponibilidad del monto dado en la tabla correspondiente
    @resultado_disponibilidad = -1

   
    if jugadalot.qpt == 'Q' # Verificar Disponibilidad de Q de xx sorteo
      @resultado_disponibilidad = controlQxxt(jugadalot)  
    end

    if jugadalot.qpt == 'P' # Verificar Disponibilidad de P de xx sorteo
      @resultado_disponibilidad = controlPxxt(jugadalot)  
    end

    if jugadalot.qpt == 'T' # Verificar Disponibilidad de T de xx sorteo
      @resultado_disponibilidad = controlTxxt(jugadalot)  
    end


    @resultado_disponibilidad # retorno valor

    # Lo mismo para las demas disponibiliada de los otros sorteos: nacional narde, real, loteka, etc..
    # if jugadalot.qpt == 'Q' && jugadalot.sorteot.sigla == '02' # Verificar Disponibilidad de Quiniela de la Nacional Noche
    #   @resultado_disponibilidad = controlQNTt(jugadalot)  
    # end
    #etc..
    
  end

# ------------

  def verificar_sorteo_cerrado ticket
    # EN GALLOS SERIA VERIFICAR PELEAS CERRARDA

      @jugadalots = Jugadalot.where(:ticket_id => ticket.id) # todos.
      @sorteos = []
      @hash_horarios = {}
      @sorteos_cerrados = []
#sort
#sacar cada dia en array value hashes
      @jugadalots.each do |jugada|
        @sorteos << jugada.sorteot.sigla.to_i# la sigla es string y para poder organizar sort y uniq lo comvierto en integer. ok ted. Luego se pasa a  string nuevamente etc.. "01" ok.
       # jugada.sorteot.horariosorteot.where(:)

      end

      @sorteos.sort! #organizo ids sorteos de menor a mayor y elimino ids repetidos.
      @sorteos.uniq! # debo hacerlo separado porque array.sort.uniq! no lo guarda de una vez
      
      @sorteos_en_siglas = []
      
      @sorteos.each do |s|
        if s < 10
         @sorteos_en_siglas << "0" + s.to_s
        else
         @sorteos_en_siglas << s.to_s
        end  

      end # end del each

      @sorteos = @sorteos_en_siglas # Ahora son string (siglas de sorteos ok)

      @sorteos.each do |sorteo_id|
        sorteo= Sorteot.find_by_sigla(sorteo_id)

        @hash_horarios["0"] = sorteo.horariosorteot.domingo.strftime("%H%M%S").to_i # El Domingo retorda wday => 0. ok ted.
        @hash_horarios["1"] = sorteo.horariosorteot.lunes.strftime("%H%M%S").to_i
        @hash_horarios["2"] = sorteo.horariosorteot.martes.strftime("%H%M%S").to_i
        @hash_horarios["3"] = sorteo.horariosorteot.miercoles.strftime("%H%M%S").to_i
        @hash_horarios["4"] = sorteo.horariosorteot.jueves.strftime("%H%M%S").to_i
        @hash_horarios["5"] = sorteo.horariosorteot.viernes.strftime("%H%M%S").to_i
        @hash_horarios["6"] = sorteo.horariosorteot.sabado.strftime("%H%M%S").to_i

        #Si es thora, haremos el  Cierre automatico provisional del sorteo.cerrado? = "si" Si ya es despues de su hora de cierre ok. ted. provisional.
        if (Time.now.strftime("%H%M%S").to_i >  @hash_horarios[Time.now.wday.to_s]) 
           sorteo.abierto = 'no' #cerrar el sorteo por si acaso. ok.
           sorteo.save!
        end # 

        #Si es temprano y esta abierto el sorteo => no ha cerrado (false); de lo contrario "true" inidica sorteo cerrado o no disponible.
       if (Time.now.strftime("%H%M%S").to_i >  @hash_horarios[Time.now.wday.to_s]) || sorteo.abierto != 'si' || sorteo.activo != 'si' # && sorteo.abierto == "si" # Ya es tarde para ese sorteo.
          @sorteos_cerrados << sorteo.nombre.to_s + " - (Cerrado)."
       end # end del if

      end # end del bloque each

      if @sorteos_cerrados.empty? # si esta vacio no hay nigun sorteo cerrado.
          return false 
        else
          return @sorteos_cerrados # retorna los sorteos cerrados (array con informacion) => 'true'      
      end
    

  end # end de la funcion



# ------------




  def last_tickect_current_user
      Ticket.where(:user_id => current_user).last # retorna el objeto del ultimo ticket del current_user
  end

  
  def sorteo_existe?(entrada)

    @array_sigla_sorteos = []
    sorteos =  Sorteot.all #includes(:sigla).where(:sigla => "#{entrada}")   # Sorteot.where(:sigla :includes ["#{entrada}"])
    
    sorteos.each do |ss|
      @array_sigla_sorteos << ss.sigla
    end

    @array_sigla_sorteos.include?(entrada) # retonra true o false si el sorteo "01" digitado por la terminal existe en el modelo Sorteots. ok esto para evitar un error al insertar un sorteo no deseado eje. sorteo "88". ok ted.
  end

  def request_ticket_id
    @t = Ticket.new
    @array_numeros =  ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

    @t.serial = @array_numeros.shuffle.join("")  # genero string aleatorio de 10 digitos del 0-9 ramdom ok.  ej. "6258741093"
    @t.user_id = current_user.id
    @t.save! # devuelve el objeto grabado en el modelo. La funcion retorna este objeto.
    @t.id # retornar el serial actual del ticket que es el id del modelo. ok.
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_jugadalot
    @jugadalot = Jugadalot.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def jugadalot_params
    params.require(:jugadalot).permit(:ticket, :n1, :n2, :n3, :monto, :qpt, :sorteo, :cliente_id, :tipo_cliente, :ubicacion)
    #params.require(:jugadalot).permit! #Los permito todos los parametros si da error cancancan manana ok ted.
  end

  def verificar_reconexion_de_usuario
     
        if (current_user.last_sign_in_at != nil) && ( current_user.last_sign_in_at.to_date < Date.today )
          # El usuario no es nuevo(entrando) y seloggeo hace tiempo (viejo)  desde ayer o anter => Hay que reconectarse. Forzar login.
          #redirect_to "users#sign_out" #sign_out_path
          #redirect_to destroy_user_session_path, method: :delete
          #sign_out_and_redirect(root_path) #⇒ Object
          sign_out_and_redirect(current_user) # ok Funcionoo este ok. sacado de link:https://stackoverflow.com/questions/25858606/how-to-devise-destroy-session-and-sign-out-from-controller
          #current_user.destroy # cierre de sesion. Debe hacer el login de hoy antes de continuar.
        end
    
  end # fin de la funcion verificar_reconexion_de_usuario


def verificar_datos_cliente_id_y_tipo_cliente

    @cliente_id = params['cliente_id'] # params.permit(:tipo_cliente) #params['cliente_id'] #require(:ciudadt).permit(:cliente_id)
    @tipo_cliente = params['tipo_cliente'] # "klk" # params['tipo_cliente'] # params.require(:ciudadt).permit(:tipo_cliente)

    #tambien lo guardo en la session para fines de acceso general desde cualquier parte del servicor 9controladores)
    session[:cliente_id] = @cliente_id
    session[:tipo_cliente] = @tipo_cliente
  
end


end # fin de la Clase.


#ALGUNAS ANOTACIONES DEL SISTEMA:
# => TICKETS:
# /at > anular ticket
# /ct > consultar ticket
# /pt > pagar ticket



#------------------------------------

# Lisdado de condicionales case entrada: 

# when /^\.\d{2}+$/ # Setear loteria manual.
# when "/h" # Consultar la hora y fehca del servidor.
# when /^\.{2}\d+$/ # Verificar si manda a imprimir ticket y monto recibido.
# when /^\d{2}\+\d+$/ # ej. 02+100 #Verificar si es Quiniela
# when /^\d{2}\+\d+\.\d{2}$/  # ej. 02+100.02 Verificar quiniela con sorteo manual especifico.
# when /^\d{4}\+\d+$/ # ej. 0220+100 #Verificar si es Pale
# when /^\d{4}\+\d+\.\d{2}$/ # ej. 0220+100.02   Verificar si es Pale en sorteo especifico.
# when /^\d{6}\+\d+$/ # ej. 010203+100 Verificar si es Tripleta
# when /^\d{6}\+\d+\.\d{2}$/ # ej. 010203+100.02 Verificar si es Tripleta en sorteo especifico.
# when "/bt"  # #borrar todo. Linea de ticket jugadalots actual.
# when "/g"  # Consultar numeros ganadores de Hoy.
# when /^\/g\+\d{2}\-\d{2}\-\d{4}$/ # "/g+31-10-2018"  # Consultar numeros ganadores x fecha.
# when /^\/g\+\d{2}\/\d{2}\/\d{4}$/ # "/g+31/10/2018"  # Consultar numeros ganadores x fecha (otro formato) (dd/mm/aaa).
# when /^\/at\d+\+\d+$/ # Anular ticket "/at123456+8855522" 
# when /^\/ct\d+\+\d+$/   # Consultar ticket "/at123456+8855522": ganador (pendiente de pago)
# when /^\/pt\d+\+\d+$/  # /pt pago de ticket. ej.  /pt321+4068295371 (pagar ticket + serail)



#<User id: 4, 

# u.email = "mr001@central.com" 
# u.telefono = "809-247-1555" 
# u.sucursalt_id = nil
# u.tipousuariot_id = 2 
# u.activo = true
# u.consorciot_id = 3
# u.sucursalbt = "mr001"
# u.siglas = "mr001"
# u.direccion = "Calle 1 Casa 2, Los Reyes, Stgo." 
# u.ciudadt_id = 1
# u.provinciat_id = 1
# u.zonat_id = 1
# u.vendedor = "Juan Lopez"
# u.contacto = "809-888-7777"
# u.supervisort_id = 1
# u.colectort_id = 1
# u.sociot_id = nil
# u.gppt_id = 1


#DEFINICION DE SORTEOS - RELACION DE SORTEOS CON SIGLAS:

# 01 -Nacional Noche.
# 02 -Ganamas.
# 03 -Quiniela Leidsa.
# 04 -Loteria Real.
# 05 -NY Noche.
# 06 -NY Tarde.
# 07 -Loteka.
# 13 -SP Leidsa-Nacional.
# 14 -SP Real-Nacional.
# 17 -SP Loteka-Nacional.



=begin   #esto es un comentario largo =begin ....... =end  ok ted ruby.

rails g scaffold controlqgmt  numero:integer limite:integer vendida:integer
rails g scaffold controlqleit numero:integer limite:integer vendida:integer
rails g scaffold controlqreat numero:integer limite:integer vendida:integer
rails g scaffold controlqnytt numero:integer limite:integer vendida:integer
rails g scaffold controlqnynt numero:integer limite:integer vendida:integer
rails g scaffold controlqltkt numero:integer limite:integer vendida:integer

rails g scaffold recordqgmt  ticket:references n1:integer monto:integer
rails g scaffold recordqleit ticket:references n1:integer monto:integer
rails g scaffold recordqreat ticket:references n1:integer monto:integer
rails g scaffold recordqnytt ticket:references n1:integer monto:integer
rails g scaffold recordqnynt ticket:references n1:integer monto:integer
rails g scaffold recordqltkt ticket:references n1:integer monto:integer

rails g scaffold controlpgmt  n1:integer n2:integer siglas limite:integer vendida:integer  
rails g scaffold controlpleit  n1:integer n2:integer siglas limite:integer vendida:integer  
rails g scaffold controlpreat n1:integer n2:integer siglas limite:integer vendida:integer
rails g scaffold controlpnytt n1:integer n2:integer siglas limite:integer vendida:integer
rails g scaffold controlpnynt n1:integer n2:integer siglas limite:integer vendida:integer
rails g scaffold controlpltkt n1:integer n2:integer siglas limite:integer vendida:integer
*****
rails g scaffold controlspleinnt n1:integer n2:integer siglas limite:integer vendida:integer
rails g scaffold controlspreannt n1:integer n2:integer siglas limite:integer vendida:integer
rails g scaffold controlspltknnt n1:integer n2:integer siglas limite:integer vendida:integer

 
rails g scaffold recordpgmt   ticket:references n1:integer n2:integer siglas  monto:integer
rails g scaffold recordpleit  ticket:references n1:integer n2:integer siglas  monto:integer
rails g scaffold recordpreat  ticket:references n1:integer n2:integer siglas  monto:integer
rails g scaffold recordpnytt  ticket:references n1:integer n2:integer siglas  monto:integer
rails g scaffold recordpnynt  ticket:references n1:integer n2:integer siglas  monto:integer
rails g scaffold recordpltkt  ticket:references n1:integer n2:integer siglas  monto:integer
*****
rails g scaffold recordspleinnt  ticket:references n1:integer n2:integer siglas  monto:integer
rails g scaffold recordspreannt  ticket:references n1:integer n2:integer siglas  monto:integer
rails g scaffold recordspltknnt  ticket:references n1:integer n2:integer siglas  monto:integer



rails g scaffold controltgmt  n1:integer n2:integer n3:integer siglas limite:integer vendida:integer
rails g scaffold controltleit n1:integer n2:integer n3:integer siglas limite:integer vendida:integer
rails g scaffold controltreat n1:integer n2:integer n3:integer siglas limite:integer vendida:integer
rails g scaffold controltnytt n1:integer n2:integer n3:integer siglas limite:integer vendida:integer
rails g scaffold controltnynt n1:integer n2:integer n3:integer siglas limite:integer vendida:integer
rails g scaffold controltltkt n1:integer n2:integer n3:integer siglas limite:integer vendida:integer

rails g scaffold recordtgmt  ticket:references n1:integer n2:integer n3:integer siglas  monto:integer seleccionada
rails g scaffold recordtleit ticket:references n1:integer n2:integer n3:integer siglas  monto:integer seleccionada
rails g scaffold recordtreat ticket:references n1:integer n2:integer n3:integer siglas  monto:integer seleccionada
rails g scaffold recordtnytt ticket:references n1:integer n2:integer n3:integer siglas  monto:integer seleccionada
rails g scaffold recordtnynt ticket:references n1:integer n2:integer n3:integer siglas  monto:integer seleccionada
rails g scaffold recordtltkt ticket:references n1:integer n2:integer n3:integer siglas  monto:integer seleccionada

=end





#controlqgmt
#recordqgmt
#controlpgmt
#recordpgmt
#controltgmt
#recordtgmt

#Ledisa "03"
#recordqleit
#controlqleit
#recordpleit
#controlpleit
#recordtleit
#controltleit


#Real "04"
#recordqreat
#controlqreat
#recordpreat
#controlpreat
#recordtreat
#controltreat


#NY Noche "05"
#recordqnynt
#controlqnynt
#recordpnynt
#controlpnynt
#recordtnynt
#controltnynt


#NY Tarde "06"
#recordqnytt
#controlqnytt
#recordpnytt
#controlpnytt
#recordtnytt
#controltnytt


#Loteka "07"
#recordqltkt
#controlqltkt
#recordpltkt
#controlpltkt
#recordtltkt
#controltltkt


# Creacion de las Lorerias:
# loteriat  ID  NOMBRE  DESCRIPCION PAIS

#01 Loteria Nacional - Loteria Nacional Dominicana - RD
#02 Leidsa - Leidsa - RD
#03 Loteria Real - Loteria Real - RD
#04 Loteria NY - Loteria NY - RD o NY?
#05 Loteka - Loteka - RD
#



# Creacion detallada de todos los sorteos en Sorteots (web rails)
# SORTEO  ID  NOMBRE  DESCRIPCION SIGLA HORARIOSORTEOT  LOTERIA_ID

#01- Nacional Noche
#02- Ganamas
#03- Quiniela Leidsa
#04- Quiniela Real
#05- NY Noche
#06- NY Tarde
#07- Loteka 



#Horariosorteots? 
#ok. compeltados
