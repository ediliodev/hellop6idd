class JugadalotsController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_jugadalot, only: [:edit, :update, :destroy]
  before_action :verificar_reconexion_de_usuario # Esto si el usuario esta loggeado desde ayer o mas viejo y si tiene cosas pendientes... etc.. session destroy y forzar login.

  # GET /jugadalots
  # GET /jugadalots.json
  
  def activar
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

    @tipo_cliente = session[:tipo_cliente] #capturo el tipo de cliente verificado en index y almacenado en la session para llegar al new y usar esta variable de control para motrar la vista web o mobile. ok. ted.
    @cliente_id = session[:cliente_id]

#LINEA PROVISIONAL DEBAJO
#redirect_to "/jugadalots/activar", notice: "Bienvenido, Favor configure el printer para continuar. Si no puede pasar de esta pantalla, favor contactar a la central para verificar si su terminal esta activada. Gracias." and return 
#redirect_to "/jugadalots/activar", notice: "Error: Debe activar su terminal, favor contactar la Central. Cierre y abra la aplicacion nuevamente o Reconfigure el printer para obviar este mensaje." and return 

    
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
              redirect_to "/jugadalots/activar", notice: "Error: Su terminal no esta autorizada. Favor contactar a la Central para su reset." and return 
            end

          else # si no se cumple alguna condicion de "if not @equipo_existe.nil?" entonces nil default.
            session[:chekeado] = nil # ok ted.
          end
     
       else
        @tipo_cliente =  @cliente_id = nil # Para que no le permita el view de venta. (Le Sale el otro view de no venta.. ok ted.)
       # session[:ya_chekeado] = 'si'
        redirect_to "/jugadalots/activar", notice: "Bienvenido! Favor configure el printer para continuar. [Presione el boton rojo BABYLOT 2.0 y luego el azul PROBAR IMPRESION]... o contacte a la Central para verificar su activacion. Gracias." and return 
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
          
          @jugadalots.each do |jugadalot|
            @total += jugadalot.monto.to_i
          end
          session[:total_tk_viejo] =  @total # esto porque al imprimit el /new [].each es 0.
        
        else
          @jugadalots = [] # en vez de nil para que cumpla con el array.each... nil.ech no existe.
         
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

    @jugadalot = Jugadalot.new(jugadalot_params)
    
    if session[:ticket_id] == nil # primer login o sin ticket...?
      @t_id = request_ticket_id()
      session[:ticket_id] = @t_id
    end


#----------------------

   h1 =  params.require(:jugadalot).permit(:qpt)
   v1 = h1[:qpt]

   if v1.empty? 
    redirect_to "/jugadalots/new", notice: "NO PUEDE ESTAR EN BLANCO" and return 
  end

   
   entrada = params.require(:jugadalot).permit(:qpt)
   entrada = entrada[:qpt]
      @stt = "888"
      
      
      #Aqui va la parte del controlador con el case..end ok ted.
      
      #case...
      
      #end..


       case entrada

         #Verificar si es seteo de loteria manual
         when /^\.\d{2}+$/ # Setear loteria manual

            entrada.slice!(0) # el slice elimina el . del .02 ok ted.
            
              @verificar0 = sorteo_existe?(entrada)

              @verificar2 = false 

              if @verificar0
                @verificar1 = session[:loteria_manual] = entrada
                @sorteo_nombre_ted = Sorteot.where(:sigla => "#{entrada}").first.nombre
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



          #Verificar si manda a imprimir ticket y monto efectvo y a devolver
          when /^\.{2}\d+$/ # Verificar si manda a imprimir ticket y monto recibido.
            
            @efectivo_recibido = entrada.split(".")[2].to_i #efectivo recibido ..100 split(".)[2] => 100

            #verificar que el efectivo recibido sea igual o mayor que el total de factura:
            if session[:total_tk_viejo].to_i >  @efectivo_recibido # falta dinero
              @diferencia_efectivo = session[:total_tk_viejo].to_i -  @efectivo_recibido  # La resta es el dinero que falta.
              redirect_to "/jugadalots/new", notice: " Cantidad Recibida " + "($#{@efectivo_recibido})" + " no es suficiente,es menor al total del ticket. Faltan $" + "#{@diferencia_efectivo} pesos" and return 
            end

            #verificar sorteos abiertos de esas jugadalots de ese ticket.
            #verificar disponibilidad nuevamente y descontar montos disponibles
            #Guardar en las tablas corresponidiente de quinieles, pales o tripletas, etc.
            #cotejar el ticket con fecha de impresion
            #imprimir
            
            #verificacion de sorteos abiertos.
             @sorteo_cerrado = verificar_sorteo_cerrado(last_tickect_current_user())  # retorna array[] o false. ok ted. ver funcion.
             if @sorteo_cerrado
              redirect_to "/jugadalots/new", notice: "Algun sorteo cerrado: " + "#{@sorteo_cerrado.join(",")}" and return # todos.
            end

            @verficiar_disponibilidad = verificar_disponibilidad_global(last_tickect_current_user)
            
            if ! (@verficiar_disponibilidad.empty?)
                redirect_to "/jugadalots/new", notice: "Algunas jugadas con Cantidad no disponible: \n" +  "#{@verficiar_disponibilidad.join(" ")}" and return # todos.                
            end
           



          #  @disponibilidad = verificar_disponibilidad(last_tickect_current_user())  # retorna array[] o false. ok ted. ver funcion.
          #  if @disponibilidad
          #  redirect_to "/jugadalots/new", notice: "Algun sorteo cerrado: " + "#{@a.join(",")}" and return 
          #  end

            if true   # OJO SI BORRAS EL IF, DEBES BORRAR EL END del mismo al final. ok. Buscarlo. (Que el sorteo este abierto y que se autorice imprimir)
             # if verificar_sorteo_cerrado? && @impresion = imprimir_ticket # imprimir y marcar como impreso
             @cotejo_tk = last_tickect_current_user()
             
            #El siguiente if piede ayudar para evitar que se reimprima un ticket si le dan para atras en el navegador(browser) alguine inventando con un ticket ya impreso en esos momentos; ok ted provisional klk? eviar impresion. 
            if @cotejo_tk.fechaimpresion != nil
              redirect_to "/jugadalots/new", notice: "Ticket impreso no se puede reimprimir. Favor /bt borrar todo y hacer un nuevo ticket para continuar." and return
            end
           
            #Nota, colocamos el registro de la venta despues de la validacion impresion nil, porue se estaba registrando venta antes de ver si ya estaba reimpreso. NO se debe registrar venta si esta reimpreso. ok. ted. la validacion y el redirect_to va primtero para evitar eso. ok. ted. (Ya que se estaban registradon ticket conv etas sin ser impresio.) ok
            #si pasa esa condicion, entonces estan todos disponibles. Vamos a descontar de las respectivas tabalas de disponibilidad
            #luego registramos la venta de las jugada en la tabla de venta de quinielas (en este caso)
            #luego vamos a marcar el ticket como impreso y este estara en la venta y candidato al sorteo si no se anula en tiempo prudente.
            @descuento_y_registro_venta = descontar_disponibilidad_y_registrar_venta(last_tickect_current_user)
            
            if @descuento_y_registro_venta == false
                redirect_to "/jugadalots/new", notice: "No se pudo descontar disponibilidad o registrar venta en la tabla. Favor llame a la Central." and return
            end  


             @cotejo_tk.fechaimpresion = Time.now # todos.
             @cotejo_tk.activo = "si" # ticket activo. si de anula debemos cambiar este status.
             session[:efectivo_recibido] =  @efectivo_recibido
            

            if @cotejo_tk.save
               session[:ticket_id] = nil  # activo flag para generar nuevo ticket.
               #imprimir_ticket() funcion o javascript klk...
               @consorcio_interno = Consorciot.where(:id => current_user.consorciot_id.to_i).first # Provisional, hasta que arreglemos la relacion has_many entre User y modelo Consorciot. ok ted. 
               
               session[:consorcio] = @consorcio_interno.nombre
               session[:telefono] = @consorcio_interno.telefono
               session[:siglas] = current_user.siglas
               session[:ticket] = @cotejo_tk.id.to_s
               session[:serial] = @cotejo_tk.serial
               session[:hora_impresion] = @cotejo_tk.fechaimpresion.strftime("%d/%m/%Y (%H:%M:%S)")
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
                      @total += jugadalot.monto.to_i
                    end

                    session[:total_impreso] =  @total


                    #verificar si el cliente es movil, hacer el cuerpo de impresion movil:
                    if session[:tipo_cliente] == "movil"

                       # @st_movil = ""

                        @st_movil = "*** " + session[:consorcio]  + " ***" + "@@"
                        @st_movil += session[:telefono]   + " - " + "(" + session[:siglas] + ")"  + "@@"
                        @st_movil +=  "Ticket: " + session[:ticket]  + "@@"
                        @st_movil +=  "Serial: " + session[:serial]  + "@@"
                        @st_movil +=  "Fecha: " +  session[:hora_impresion] + "@@"
                        @st_movil += "@@"



                        @lineas_jugadas = @impresion.jugadas.split(";") # Separo las lineas de instruccion jugadas por ; de java. ok.
                        
                        @lineas_jugadas.each do |fila|
                        
                          fila = fila[67..fila.size]
                          fila = fila.split("\\")[0]
                          fila = fila.split("\"")[0] # para filtar algunos caracteres basura que salieron impreso. ok.ted.
                          @st_movil << fila.to_s + "@@"

                        end
                        @st_movil += "@@"
                        @st_movil += "Total: $" + session[:total_impreso].to_s + "@@"
                        @st_movil += "@@"
                        @st_movil +=  "Ticket: " + session[:ticket]  + "@@"
                        @st_movil +=  "Serial: " + session[:serial]  + "@@"
                        @st_movil +=   session[:mensaje1]  + "@@"

                        session[:st_movil] = @st_movil

                        session[:esperar_ubicacion] = "si"

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
            redirect_to "/jugadalots/new", notice: "No se pudo imprimir, no se pudo setear el ticket.fechaimpresion o algo relacionado. Favor reitentar o llamar al a Central." and return 
          end


     
      #Verificar si es Quiniela

        when /^\d{2}\+\d+$/ # ej. 02+100 #Verificar si es Quiniela

            @cadena = entrada.split("+")
            @quiniela = @cadena[0]
            @monto = @cadena[1]
            @jugadalot.qpt = "Q"
            @jugadalot.n1 = @quiniela
            @jugadalot.monto = @monto.to_i

            if  session[:loteria_manual] != nil
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
              redirect_to "/jugadalots/new", notice: "Cantidad no disponible"  and return 
            end

            if session[:loteria_manual] != nil &&  @jugadalot.save 
              redirect_to "/jugadalots/new"  and return 
            else
              redirect_to "/jugadalots/new", notice: "No se pudo grabar esta jugada en ticket_line. Error. " + "#{@mensaje2}" + "#{session[:loteria_manual]}" and return 
            end


        when /^\d{2}\+\d+\.\d{2}$/  # ej. 02+100.02 Verificar quiniela con sorteo manual especifico.
            # ej. entrada tiene = "25+500.02"
            @cadena = entrada.split("+")
            @quiniela = @cadena[0] #"25"
            @monto = @cadena[1].split(".")[0] # "25,500.02" >> "500"
            @jugadalot.monto = @monto.to_i

            @verificar_sorteo_en_quiniela = sorteo_existe?( @cadena[1].split(".")[1])

            if @verificar_sorteo_en_quiniela
              @jugadalot.sorteot_id = Sorteot.where(:sigla => @cadena[1].split(".")[1].to_s).first.id   # "25,500.02" >> ".02"   Sorteo especifico digitado. 
            end
           
            if  session[:ticket_id] != nil # Me aseguro que el ticket exista antes de asignarlo. ok. 
              @jugadalot.ticket_id = session[:ticket_id] # asocio la jugada con su ticket actual correspondiene.
            else
               redirect_to "/jugadalots/new", notice: "No se pudo grabar esta jugada porque no tiene un ticket_id de session asignado. Favor borrar todo (/bt) y hace nueva jigada con contacte la Central." and return 
            end


            @jugadalot.qpt = "Q"
            @jugadalot.n1 = @quiniela

            @error_sorteo = ""
            if not @verificar_sorteo_en_quiniela
            @error_sorteo = "Error sorteo: " + @cadena[1].split(".")[1]
            end
            
             if verificar_disponibilidad_simple(@jugadalot) < 0
              redirect_to "/jugadalots/new", notice: "Cantidad no disponible"  and return 
            end


            if @verificar_sorteo_en_quiniela && @jugadalot.save
              redirect_to "/jugadalots/new"  and return 
            else
              redirect_to "/jugadalots/new", notice: "No se pudo grabar esta jugada en ticket_line. Error. " + @error_sorteo and return 
            end

          #trabajar los pales, organizar numeros menos a mayor, y mostrar asi mismo, ademas considerar totales, etc..
          #poner el teclado verde klk...
          #aregar el boton borrar del teclado @ <--

      #Verificar si es Pale
        when /^\d{4}\+\d+$/ # ej. 0220+100 #Verificar si es Pale
          
            @cadena = entrada.split("+")
            @digitos_pale= @cadena[0] # "0220"
            @n1 = @digitos_pale[0] + @digitos_pale[1] # "02" String
            @n2 = @digitos_pale[2] + @digitos_pale[3] # "20" String

            if @n1.to_i > @n2.to_i # Ordenar pale de menor a mayor.
              @x = @n1
              @n1 = @n2
              @n2 = @x
            end

            @monto = @cadena[1]
            @jugadalot.qpt = "P"
            @jugadalot.n1 = @n1
            @jugadalot.n2 = @n2
            @jugadalot.monto = @monto.to_i

            if  session[:loteria_manual] != nil
              @jugadalot.sorteot_id = Sorteot.where(:sigla => session[:loteria_manual].to_s).first.id  # "Next" Proximo sorteo del dia de hoy disponible. O sea sorteo actual abierto hora de cierre menor es el primero en cerrar.
            end

            @jugadalot.ticket_id = session[:ticket_id] # asocio la jugada con su ticket actual correspondiene.


            if session[:loteria_manual] == nil
              @mensaje2 = "Debe setear una Loteria."
              redirect_to "/jugadalots/new", notice: "No se pudo grabar esta jugada en ticket porque debes setear o especificar un sorteo de una loteria para la jugada. Ej. 0220+01.01 Favor intentar nuevamente." and return 
             end

             #verificar disponibilidad de Pale.
              if verificar_disponibilidad_simple(@jugadalot) < 0
                redirect_to "/jugadalots/new", notice: "Cantidad no disponible para ese Pale."  and return 
              end

            if session[:loteria_manual] != nil && @jugadalot.save
              redirect_to "/jugadalots/new"  and return 
            else
              redirect_to "/jugadalots/new", notice: "No se pudo grabar esta jugada en ticket_line. Error. " + "#{@mensaje2}" and return 
            end

    

        when /^\d{4}\+\d+\.\d{2}$/ # ej. 0220+100.02   Verificar si es Pale en sorteo especifico.

           @cadena = entrada.split("+")

            @digitos_pale= @cadena[0] # "0220"
            @n1 = @digitos_pale[0] + @digitos_pale[1] # "02" String
            @n2 = @digitos_pale[2] + @digitos_pale[3] # "20" String

            if @n1.to_i > @n2.to_i # Ordenar pale de menor a mayor.
              @x = @n1
              @n1 = @n2
              @n2 = @x
            end

            @monto = @cadena[1].split(".")[0]
            @jugadalot.qpt = "P"
            @jugadalot.n1 = @n1
            @jugadalot.n2 = @n2
            @jugadalot.monto = @monto.to_i
            @jugadalot.ticket_id = session[:ticket_id] # asocio la jugada con su ticket actual correspondiene.

            @verificar_sorteo_en_pale = sorteo_existe?( @cadena[1].split(".")[1])
             if @verificar_sorteo_en_pale
              @jugadalot.sorteot_id = Sorteot.where(:sigla => @cadena[1].split(".")[1].to_s).first.id   # "25,500.02" >> ".02"   Sorteo especifico digitado. 
            end

            @error_sorteo = ""
            if not @verificar_sorteo_en_pale
            @error_sorteo = "Error sorteo: " + @cadena[1].split(".")[1]
            end
            
            #verificar disponibilidad de Pale.
            if verificar_disponibilidad_simple(@jugadalot) < 0
              redirect_to "/jugadalots/new", notice: "Cantidad no disponible para ese Pale."  and return 
            end

            if @verificar_sorteo_en_pale && @jugadalot.save
              redirect_to "/jugadalots/new"  and return 
            else
              redirect_to "/jugadalots/new", notice: "No se pudo grabar esta jugada P en ticket_line. Error. " + @error_sorteo and return 
            end

            

      #Verificar si es Tripleta
        when /^\d{6}\+\d+$/ # ej. 010203+100 Verificar si es Tripleta

           @cadena = entrada.split("+")  # ej. "405003+10"
            @digitos_tripleta= @cadena[0] # "405003"
            @n1 = @digitos_tripleta[0] + @digitos_tripleta[1] # "40" String
            @n2 = @digitos_tripleta[2] + @digitos_tripleta[3] # "50" String
            @n3 = @digitos_tripleta[4] + @digitos_tripleta[5] # "03" String

            @ordenar = @n1, @n2, @n3
            @ordenar.sort!
            @n1 = @ordenar[0]
            @n2 = @ordenar[1]
            @n3 = @ordenar[2]

            @monto = @cadena[1]
            @jugadalot.monto = @monto.to_i
            @jugadalot.qpt = "T"
            @jugadalot.n1 = @n1
            @jugadalot.n2 = @n2
            @jugadalot.n3 = @n3

            if  session[:loteria_manual] != nil
              @jugadalot.sorteot_id = Sorteot.where(:sigla => session[:loteria_manual].to_s).first.id  # "Next" Proximo sorteo del dia de hoy disponible. O sea sorteo actual abierto hora de cierre menor es el primero en cerrar.
            end

            @jugadalot.ticket_id = session[:ticket_id] # asocio la jugada con su ticket actual correspondiene.

             if session[:loteria_manual] == nil
              @mensaje2 = "Debe setear una Loteria."
              redirect_to "/jugadalots/new", notice: "No se pudo grabar esta jugada en ticket porque debes setear o especificar un sorteo de una loteria para la jugada. Ej. 010203+01.01 Favor intentar nuevamente." and return 
             end

            #verificar disponibilidad de Tripleta.
            if verificar_disponibilidad_simple(@jugadalot) < 0
              redirect_to "/jugadalots/new", notice: "Cantidad no disponible para esa Tripleta."  and return 
            end

            if session[:loteria_manual] != nil &&  @jugadalot.save
              redirect_to "/jugadalots/new"  and return 
            else
              redirect_to "/jugadalots/new", notice: "No se pudo grabar esta jugada en ticket_line. Error. "  + "#{@mensaje2}" and return 
            end


        when /^\d{6}\+\d+\.\d{2}$/ # ej. 010203+100.02 Verificar si es Tripleta en sorteo especifico.

            @cadena = entrada.split("+")  # ej. "405003+10.02"
            @digitos_tripleta= @cadena[0] # "405003"
            @n1 = @digitos_tripleta[0] + @digitos_tripleta[1] # "40" String
            @n2 = @digitos_tripleta[2] + @digitos_tripleta[3] # "50" String
            @n3 = @digitos_tripleta[4] + @digitos_tripleta[5] # "03" String

            @ordenar = @n1, @n2, @n3
            @ordenar.sort!
            @n1 = @ordenar[0]
            @n2 = @ordenar[1]
            @n3 = @ordenar[2]

            @monto = @cadena[1].split(".")[0]
            @jugadalot.monto = @monto.to_i
            @jugadalot.qpt = "T"
            @jugadalot.n1 = @n1
            @jugadalot.n2 = @n2
            @jugadalot.n3 = @n3
            @jugadalot.ticket_id = session[:ticket_id] # asocio la jugada con su ticket actual correspondiene.
            @verificar_sorteo_en_tripleta = sorteo_existe?( @cadena[1].split(".")[1])

            @verificar_sorteo_en_tripleta = sorteo_existe?( @cadena[1].split(".")[1])
            
            if @verificar_sorteo_en_tripleta
              @jugadalot.sorteot_id = Sorteot.where(:sigla => @cadena[1].split(".")[1].to_s).first.id   # "25,500.02" >> ".02"   Sorteo especifico digitado. 
            end

            @error_sorteo = ""
            if not @verificar_sorteo_en_tripleta
            @error_sorteo = "Error sorteo: " + @cadena[1].split(".")[1]
            end
            
            #verificar disponibilidad de Tripleta.
            if verificar_disponibilidad_simple(@jugadalot) < 0
              redirect_to "/jugadalots/new", notice: "Cantidad no disponible para esa Tripleta."  and return 
            end

            if @verificar_sorteo_en_tripleta && @jugadalot.save
              redirect_to "/jugadalots/new"  and return 
            else
              redirect_to "/jugadalots/new", notice: "No se pudo grabar esta jugada T en ticket_line. Error. " + @error_sorteo and return 
            end

          when "/bt"  # #borrar todo. Linea de ticket jugadalots actual.
            session[:efectivo_recibido] = nil
            session[:total_tk_viejo] = nil
            borrar_todo_jugadalots_actual(last_tickect_current_user)
            #session[:ticket_id] = nil # actvio flag para genrear un nuevo ticket mejor.
            redirect_to "/jugadalots/new", notice: "Jugadas en Limpio...ok. " and return 
            #listo 

          when "/g"  # Consultar numeros ganadores de Hoy.
            #@numeros_ganadores = Ganadorest.by_day(Date.today)
            @numeros_ganadores = Ganadorest.where(:fecha => Date.today)
            
            if @numeros_ganadores.empty?
              redirect_to "/jugadalots/new", notice: "No se han procesado Ganadores en el dia de hoy. Por favor trate mas tarde o contacte a la Central." and return
            end

            @resultados = []

            @numeros_ganadores.each do |ganadores|
              @fecha   = ganadores.fecha.strftime("%d/%m/%y").to_s
              @sorteo  = ganadores.sorteot.nombre
              @primero = ganadores.primero < 10 ? ("0" + ganadores.primero.to_s) : ganadores.primero.to_s
              @segundo = ganadores.segundo < 10 ? ("0" + ganadores.segundo.to_s) : ganadores.segundo.to_s
              @tercero = ganadores.tercero < 10 ? ("0" + ganadores.tercero.to_s) : ganadores.tercero.to_s
              @resultados << "Sorteo: " + @sorteo + " => " + @primero + " - " + @segundo + " - " + @tercero + " | "
            end

            redirect_to "/jugadalots/new", notice: "GANADORES (#{@fecha}): " + @resultados.join("") and return


          when /^\/g\+\d{2}\-\d{2}\-\d{4}$/ # "/g+31-10-2018"  # Consultar numeros ganadores x fecha.

            @fecha = entrada.split("+")[1] 
            #@fecha = @fecha.split("-").reverse.join("-") # para poner la feche en fomrato americano ej. 31-10-2018 to 2018-10-31 ok. 

            
            @numeros_ganadores = Ganadorest.by_day(@fecha, field: :fecha)
            #numeros_ganadores = Ganadorest.where(:fecha => @fecha)

            if @numeros_ganadores.empty?
              redirect_to "/jugadalots/new", notice: "No se han procesado Ganadores en el dia de hoy. Por favor trate mas tarde o contacte a la Central." and return
            end

            @resultados = []

            @numeros_ganadores.each do |ganadores|
              @fecha   = ganadores.fecha.strftime("%d/%m/%y").to_s
              @sorteo  = ganadores.sorteot.nombre
              @primero = ganadores.primero < 10 ? ("0" + ganadores.primero.to_s) : ganadores.primero.to_s
              @segundo = ganadores.segundo < 10 ? ("0" + ganadores.segundo.to_s) : ganadores.segundo.to_s
              @tercero = ganadores.tercero < 10 ? ("0" + ganadores.tercero.to_s) : ganadores.tercero.to_s
              @resultados << "Sorteo: " + @sorteo + " => " + @primero + " - " + @segundo + " - " + @tercero + " | "
            end

            redirect_to "/jugadalots/new", notice: "GANADORES (#{@fecha}): " + @resultados.join("") and return


         when /^\/g\+\d{2}\/\d{2}\/\d{4}$/ # "/g+31/10/2018"  # Consultar numeros ganadores x fecha (otro formato) (dd/mm/aaa).

            @fecha = entrada.split("+")[1] 
            #@fecha = @fecha.split("-").reverse.join("-")

            @numeros_ganadores = Ganadorest.by_day(@fecha, field: :fecha)
            #numeros_ganadores = Ganadorest.where(:fecha => @fecha)

            if @numeros_ganadores.empty?
              redirect_to "/jugadalots/new", notice: "No se han procesado Ganadores en el dia de hoy. Por favor trate mas tarde o contacte a la Central." and return
            end

            @resultados = []

            @numeros_ganadores.each do |ganadores|
              @fecha   = ganadores.fecha.strftime("%d/%m/%y").to_s
              @sorteo  = ganadores.sorteot.nombre
              @primero = ganadores.primero < 10 ? ("0" + ganadores.primero.to_s) : ganadores.primero.to_s
              @segundo = ganadores.segundo < 10 ? ("0" + ganadores.segundo.to_s) : ganadores.segundo.to_s
              @tercero = ganadores.tercero < 10 ? ("0" + ganadores.tercero.to_s) : ganadores.tercero.to_s
              @resultados << "Sorteo: " + @sorteo + " => " + @primero + " - " + @segundo + " - " + @tercero + " | "
            end

            redirect_to "/jugadalots/new", notice: "GANADORES (#{@fecha}): " + @resultados.join("") and return



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

              #verificar que sea de este usuario/sucursal:
              if (@t_valido.user_id != current_user.id) # || (not current_user.admin?) PENDIENTE.
                redirect_to "/jugadalots/new", notice: "X Este usuario no puede anular este ticket. No eres admin o el ticket no es de esta sucursal " and return 
              end

              #Verificar si el ticket no es de HOY (Tambien podemos verificar  con la gema by_star y es de hoy y hace 10min. o menos de realizado o tiene mas de ahi.. PENDIENTe)
              if not (Ticket.by_day(Date.today).ids).include?(@t_valido.id)
                redirect_to "/jugadalots/new", notice: "X Este ticket no puede ser anulado. No es de hoy. Favor verificar" and return 
              end

              #etc.. entre otras condiciones a veriicar despues..
              #NOTA: >> HAY QUE ITERAR EL TICKET Y VERICIAR QUE NO HAYAN SORTEOS CERRADOS EN ESE TICKET PARA QUE SE PUEDA ANULAR.  CON UNO SOLO QUE ENCUENTRES CERRADO NO SE PUEDE ANULAR ESE TICKET, OK TED PENDIENTE.

              # Condicional NO se pueden anular tickets pasado 10 minutos de su impresion:
              if ( @t_valido.fechaimpresion < (Time.now - 10.minutes) && current_user.tipousuariot_id != 2 )# diferente de 2 (no admin); si es true, pasaron 10minutos, no se puede anular por aqui. con este usuario
                redirect_to "/jugadalots/new", notice: "X Este ticket no puede ser anulado pasado 10 minutos. Favor explicar  al cliente o llamar a la Central." and return 
              end

              #verifcar_algun_sorteo_cerrado de @ticekt.
              @algun_sorteo_cerrado = verifcar_algun_sorteo_cerrado(@t_valido)
              if @algun_sorteo_cerrado
                redirect_to "/jugadalots/new", notice: "X Este ticket no puede ser anulado. Ya tiene sorteos cerrados: " + "#{@algun_sorteo_cerrado.join(",")}" and return 
              end

              #proceder a anular:

              @t_valido.activo = "no"
              #Retornar disponibilidad y eliminar la venta de la tabla de quinielas o pale o tripletas etc..
              @retornar = retornar_disponibilidad_y_eliminar_venta(@t_valido)


              if (@t_valido.save && @retornar)
                @monto_tk = Jugadalot.where(:ticket => @t_valido).sum(:monto)
                redirect_to "/jugadalots/new", notice: "OK. Ticket anulado OK. Ticket: #{@t_valido.id} S/N: #{@t_valido.serial} Monto: $#{@monto_tk}. Favor archivar y marcar el ticket como NULO" and return 
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

              #ticket existe con informacion suministrada?
              @t_valido = Ticket.where(:id => @ticket , :serial => @serial).first

              if not @t_valido
                redirect_to "/jugadalots/new", notice: "X No se pudo consultar este ticket. Ticket o Serial invalido. Favor verificar nuevamente " and return 
              end 

              @activo =  @t_valido.activo.nil? ?  "PDTE." : @t_valido.activo.to_s
              @ganador =  @t_valido.ganador.nil? ? "PDTE." : @t_valido.ganador.to_s
              @pago =  @t_valido.pago.nil? ?  "PDTE." : @t_valido.pago.to_s
              @sucursal =  @t_valido.user.sucursalbt

              @st =  @mensaje_pago = "" # Declarada para que  no sean nil. ok ted. 

              if @t_valido.ganador == "si"
                @total_pagar = Ticketsganadorest.where(:ticket_id => @t_valido.id).sum(:montoacobrar)
                @st = ">> Total a pagar: $".upcase  + ActionController::Base.helpers.number_to_currency(@total_pagar.to_s, :unit => "", :delimiter => ",", :precision => 0, :separator => ".") + "<<"
                
                if (@t_valido.pago == nil || @t_valido.pago == "no")
                  @mensaje_pago = "Para pagar y registrar el ticket DEBE digitar /pt#{@t_valido.id}+serial"
                end

              end


              redirect_to "/jugadalots/new", notice: "Status ticket consultado:   Activo: #{@activo.upcase},   Ganador: >> #{@ganador.upcase} <<,  Scursal: #{@sucursal} ,  Pago: #{@pago.upcase} " + @st + " " + @mensaje_pago and return 

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


              if (@t_valido.activo == "si" && @t_valido.ganador == "si" && ( @t_valido.pago == "no" || @t_valido.pago == nil) )
                  @t_valido.pago = "si"
                  @t_valido.pagadopor = current_user.email
                  @t_valido.save
                  @total_pagar = Ticketsganadorest.where(:ticket_id => @t_valido.id).sum(:montoacobrar)
                  redirect_to "/jugadalots/new", notice: "Ticket pagado correctamente ($#{@total_pagar} pesos). Favor guardar el ticket pagado como constancia." and return                   
              end

               if (@t_valido.activo != "si")
                redirect_to "/jugadalots/new", notice: "Este ticket no puede ser pagado porque es nulo o no esta activo en el sistema. Favor contactar central." and return                   
               end

              redirect_to "/jugadalots/new", notice: "No se pudo procesar este pago. Favor intentar nuevamente o contacte la central." and return 

        
         else # Este else es del condicional case (En caso de que case entrada no cumpla, else no se entiende la jugada. Esto no deja que el codigo siga hacia abajo. ok ted. es como el break o return de este controlador en esta parte de la logica implementada...)

          redirect_to "/jugadalots/new", notice: "NO SE ENTIENDE ESTA JUGADA:  #{entrada}, FAVOR REVISAR FORMATO NUEVAMENTE" and return 
        
      end

       
  end

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

  
  #DEFINICION DE FUNCIONES PRIVADAS:

  private

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
    

  end



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

        if @jugadalots.empty?
          session.destroy # sacar el usuario ?
          #Si no hay jugadas a limpiar es porque estan neciando con el comando /bt o Enter pisado. Dar un time delay y litso. Esto para no cargar el rails server de requests no necesarios. Logica.
          sleep 3 # 5 segundos delay.
        end
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
        @sorteos_en_siglas << "0" + s.to_s
      end

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

    @array_sigla_sorteos.include?(entrada) # retonra tru o false si el sorteo "01" digitado por la terminal existe en el modelo Sorteots. ok esto para evitar un error al insertar un sorteo no deseado eje. sorteo "88". ok ted.
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
 
rails g scaffold recordpgmt   ticket:references n1:integer n2:integer siglas  monto:integer
rails g scaffold recordpleit  ticket:references n1:integer n2:integer siglas  monto:integer
rails g scaffold recordpreat  ticket:references n1:integer n2:integer siglas  monto:integer
rails g scaffold recordpnytt  ticket:references n1:integer n2:integer siglas  monto:integer
rails g scaffold recordpnynt  ticket:references n1:integer n2:integer siglas  monto:integer
rails g scaffold recordpltkt  ticket:references n1:integer n2:integer siglas  monto:integer

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