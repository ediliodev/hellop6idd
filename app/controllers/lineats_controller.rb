class LineatsController < ApplicationController
  before_action :set_lineat, only: [:show, :edit, :update, :destroy, :cerrar]

  # GET /lineats
  # GET /lineats.json
  def index
    #@lineats = Lineat.all.today.order(:pelea) # SACAR LAS DE HOY OK.
    @lineats = Lineat.all.today.sort_by { |a| + (a.pelea.to_i) } #no comprendo pero funciona el - por el + eviata el metodo .reverse ok. verificar luego. Sacado de link: https://stackoverflow.com/questions/6277127/sort-string-containing-numbers-in-ruby-rails


  end

  # GET /lineats/1
  # GET /lineats/1.json
  def show
    redirect_to lineats_url # no es necesario un show de cada pelea agregada ok ted.
  end

  # GET /lineats/new
  def new
     @lineat = Lineat.new
    
     @linealast = Lineat.last 

    if not @linealast.nil? # primera linea creada exita?
      @linealast = Lineat.last 
      @lineat.pelea = @linealast.pelea.to_i + 1
      @lineat.coliseo = @linealast.coliseo
      @lineat.bloque = @linealast.bloque
      @lineat.tiempoml = @linealast.tiempoml
      @lineat.oua = @linealast.oua
      @lineat.oub = @linealast.oub  
    end
    
  end

  # GET /lineats/1/edit
  def edit

  if params[:id].to_s.split("-")[1] == "klk"
    #params[:id] = params[:id].to_s.split("-")[0].to_i #volver a convertir luego de detectado ok.
    @lineat = Lineat.find(  params[:id].to_s.split("-")[0].to_i )
    @lineat.status = "cerrada"
    
    if @lineat.save
       redirect_to "/lineats", notice: "PELEA #{@lineat.pelea} CERRADA OK" and return 
    else  
      redirect_to "/lineats", notice: "X. TRATE DE NUEVO X." and return 
    end

  end

   

    #format.html { redirect_to lineats_url, notice: 'Cerrada ok' }
    #edit la refiere al formulario de edit de una vez, el controller no procesa nada noramlmente, pero en nuestro caso agregaremos una accion truqeada para desde aqui mismo poder cerrar la pelea directamente sin tener que entrar al formulrio ok ted 
    #if ( set_lineat.to_s.split("-")[1] == "klk" )
    #  redirect_to "/jugadalots/new", notice: "8888 " and return 
      #redirect_to lineats_url, notice: 'Cerrada okkkkkkkkkk'and return
      #cerrar pelea y redireccionar index ok
      #@lineat = Lineat.find(set_lineat.to_s.split("-")[0]) #buscar la linea actual en base al id enviado url
      #@lineat.status = "cerrada"
      #if @lineat.save
      #  format.html { redirect_to lineats_url, notice: 'Cerrada ok' }
      #else
     #   format.html { redirect_to lineats_url, notice: 'X .Intente de nuevo X' }
     # end

   # end

  end

  # POST /lineats
  # POST /lineats.json
  def create
    @lineat = Lineat.new(lineat_params)
    #conversion a to_i para estandarizar los atributos de num de bloque y de num de pelea de "01" a "1" ok por ejemplo ok.
    @lineat.bloque = @lineat.bloque.to_i
    @lineat.pelea = @lineat.pelea.to_i

    if (@lineat.pelea.to_i <= 0) # no peleas negativas. Ok.
         redirect_to :back, notice: "X Error: Numero de pelea invalido. >=1?" and return                  
    end  

  #ESTO NO ES NECESARIO POR AHORA, LA ASIGNACIND E RANGO PUEDE SER MANUAL, YA QUE CADA DIA EMPIEZA UNA LELA 1 EN UN POSIBLE COLISE DISTINTO. LO QUE PROCEDE ES MANUAL, SUBIR AL RANGO DE LOS 100+ AL SEGUNDO COLISEO EN CURSO OK.
  #VERIFICAR COLISEO PARA ASIGNAR RANGOS DE SECUENCIA X COLISEO: 0-100:STGO
  #verifcar coliseo del updata para saber si hay cambios de secuencia como en la accion new ok.
   # if @lineat.coliseo == "Santiago"  
   #   if not ( (@lineat.pelea.to_i > 0) && (@lineat.pelea.to_i < 100) )
   #     redirect_to :back, notice: "X Error: Rango de pelea invalido. El rango para este Coliseo es: [1 hasta 99]." and return          
   #   end
   # end
   # if @lineat.coliseo == "Sto. Dgo."  
   #   if not ( (@lineat.pelea.to_i > 100) && (@lineat.pelea.to_i < 200) )
   #     redirect_to :back, notice: "X Error: Rango de pelea invalido. El rango para este Coliseo es: [101 hasta 199]." and return          
   #   end
   # end
   # if @lineat.coliseo == "SFM"  
   #   if not ( (@lineat.pelea.to_i > 200) && (@lineat.pelea.to_i < 300) )
   #     redirect_to :back, notice: "X Error: Rango de pelea invalido. El rango para este Coliseo es: [201 hasta 299]." and return          
   #   end
   # end
    


    respond_to do |format|
      if @lineat.save
        if not @lineat.resultado.empty? # si no esta vacio, es porque HAY UN RESULTADO COMPUTADO EN CREATE, por tanto, cerramos la pelea con resultados ya mismo. Nos aseguramos de cerrar la pelea par no mas apuestas, seteando condicion status a "cerrada" ok.
          @lineat.status = "cerrada"
          @lineat.save
        end
        format.html { redirect_to @lineat, notice: 'Linea creada exitosamente.' }
        format.json { render :show, status: :created, location: @lineat }
      else
        format.html { render :new }
        format.json { render json: @lineat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lineats/1
  # PATCH/PUT /lineats/1.json
  def update
    respond_to do |format|

      #verificar si tiempofinalizado tiene algun valor para guardar, si es asi, verificar que minutos y segundos sean correctos <60 ok
      if  not lineat_params[:tiempofinalizado].empty? # si no esta vacio, trae algo.
        minutos =  lineat_params[:tiempofinalizado].split(".")[0].to_i
        segundos = lineat_params[:tiempofinalizado].split(".")[1].to_i
        if (minutos.to_i > 59.to_i) || (segundos.to_i > 59.to_i ) 
          redirect_to :back, notice: "X Error: Digitacion de tiempo finalizado invalido." and return          
        end
      end


    if (lineat_params[:pelea].to_i <= 0) # no peleas negativas.
        redirect_to :back, notice: nil and return #No muuestra mensaje de error pero vuelve a acargar el valor original si se computa una pelea negativa tratando de editar ok. ted. good.            
    end



      if @lineat.update(lineat_params)
        #aprovechar y setear num de bloque y num de pelea como integer en el string para evitar  "01" poR 1 ok ted
        #arbitrariamente en todas las ediciones ok ted faster logic ok.
        @lineat.bloque = @lineat.bloque.to_i
        @lineat.pelea = @lineat.pelea.to_i
        @lineat.save #guardar cambios anteriores.



        if not @lineat.resultado.empty? # si no esta vacio, es porque HAY UN RESULTADO EN UPDATE, Nos aseguramos de cerrar la pelea par no mas apuestas, seteando condicion status a "cerrada" ok.
          #verificar que le hayan puiesto un timepo de finalizacion, antes de cambiar status a cerrado debajo del if end condition ok
          if @lineat.tiempofinalizado.empty?
            @lineat.status = "cerrada"
            @lineat.resultado = "" # esto para evitar ganador azul sin timepo por ejemplo ok.
            @lineat.save
            redirect_to :back, notice: "X Error: Resultado sin tiempo de finalizacion. Nota: para TABLA o NULA completar tiempofinalizado con 10.00 min" and return
          end

          @lineat.status = "cerrada"
          @lineat.save
        end

        # no procesar si tiene tiempofinalizado pero sin cita ganadora de resultado, no procesar tampoco:
        if ( not @lineat.tiempofinalizado.empty? ) && (@lineat.resultado.empty?)
          @lineat.status = "cerrada"
          @lineat.tiempofinalizado = "" # esto para evitar ganador azul sin timepo por ejemplo ok.
          @lineat.save
          redirect_to :back, notice: " X Error: Resultado sin Cinta Ganadora. Debe computar la Cinta Ganadora y el tiempo de finalizacion correctamente" and return
        
        end

        #EN ESTA SECCION SE EJECUTAN LOS METODOS DE PROCESAMIENTO DE RESULTADOS,
        #PROCESAR GANADORES
        #PROCESAR RESULTADOS DE VTAS ETC.
        #SALIR NORMAL AL PANEL DE LINEAS NUEVAMENTE OK.



        format.html { redirect_to @lineat, notice: 'Linea actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @lineat }
      else
        format.html { render :edit }
        format.json { render json: @lineat.errors, status: :unprocessable_entity }
      end

    end
  end

  # DELETE /lineats/1
  # DELETE /lineats/1.json
  def destroy
    @lineat.destroy
    respond_to do |format|
      format.html { redirect_to lineats_url, notice: 'Linea was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def cerrar
    @lineat.status = "cerrada"
     
    if @lineat.save # actualizar cierre pelea ok
       format.html { redirect_to lineats_url, notice: 'PELEA #{@lineat.pelea} CERRADA CORRECTAMENTE OK.' }
    else
      format.html { redirect_to lineats_url, notice: 'X No se pudo. Trate de Nuevo.' }
    end

  end


  def procesar_resultados
    flag_procesamiento_ok = true
    razon = "" # razon del error en caso de detalles ok.

    #Listar todos los ticket de hoy?Peleas cerradas.
    #Gestionar el procesamiento de los resultados en este controlador.
    #buscar todas las peleas de hoy con las siguientes condiciones: Cerrala y Resultado no nulo (si no esta nulo tinen algun resultado). VERIFICAR CASO CUANDO EL RESULTADO ES NULO EN COMPUTACION DEL TICKET OK.
    #Procesar condicion del ticket en base a resutlados de cinta, tiempo, anulaciones y tabla (lo mismo?)
    #Recarcular pago y condicion del ticket,  analizando cada juagada del mismo?
    #agregar a tabla de tickets ganadores (Para fines de reportes y tracking?
    @todas_peleas_finalizadas_de_hoy =  Lineat.today.where(:status => "cerrada") # finalizadas pero seleccionaremos solo las que tienen resultado no vacios ok
    

    #buscar las que tienen resultados:
    @lineas_enterradas = [] # lineas enterradas son aquellas cerradas manualmente y con resultados finales definitivos ok.
    
    @lineas_peleas_nulas = [] # todas las peleas con nula (cambiaran a la condicion de emapte) 
    @lineas_peleas_tabla = [] # todas las peleas tabla (cambiaran a la condicion de emapte tambien) 

    #@lineas_peleas_nulas =  Lineat.today.where(:status => "cerrada", :resultado => "empate") || []
    #@lineas_peleas_tabla  = Lineat.today.where(:status => "cerrada", :resultado => "empate") || []

    @todas_peleas_finalizadas_de_hoy.each do |lineat|
      if ( (lineat.resultado != "") && ( lineat.resultado != "nula") && (  lineat.resultado != "tabla") ) # tiene algun resultado, agregar al arreglo.
        @lineas_enterradas << lineat
      end

      if lineat.resultado == "empate" #
       @lineas_peleas_nulas << lineat  
      end

      if lineat.resultado == "empate" #
        @lineas_peleas_tabla << lineat
      end
      
    end # end del loop @todas_peleas_finalizadas_de_hoy.each do |lineat|

    #obtuvimos todas las peleas finalizadas conresultados. Procesarlas
    #Actualizar condicion de resultados de jugadalots de cad ticket con esa pelea o casa jugadalot de hoy con esa pelea mejor?
    #Busncar todas las jugadas de hoy con esas peleas en su lista.
    #@todas_las_jugadas_a_procesar_semi_ganadoras_color_cinta = []
   
    
    @lineas_enterradas.each do |linea_enterrada|
      cinta            =  linea_enterrada.resultado
      tiempoml         =  linea_enterrada.tiempoml
      tiempofinalizado =  linea_enterrada.tiempofinalizado
      
      
      

      #Calcular coincidencias de cinta color azul o blanco:
      @todas_las_jugadas_a_procesar_semi_ganadoras_color_cinta = Jugadalot.today.where(:pelea => linea_enterrada.pelea) # Encontrar jugadas de hoy con la pelea correspondiente al mismo numero de la pelea de la linea finalizada ok
      #ejempl hasta aqui todas las de las pelea 11, en el prx each, todas las de las peleas 12, etc...
      #todas ganadoras azul azul, blanco blanco, ACIERTO POSOTIVIO EACH.
      if not @todas_las_jugadas_a_procesar_semi_ganadoras_color_cinta.empty? # si existen, actualizar como aciertos positivos
        #:apuestacinta => linea_enterrada.resultado
        @todas_las_jugadas_a_procesar_semi_ganadoras_color_cinta.each do |jugadalot|
        
          if ( (linea_enterrada.resultado == "azul") || (linea_enterrada.resultado == "blanco") )
              if ( (jugadalot.apuestacinta == linea_enterrada.resultado)  )
                 jugadalot.acierto = "positivo"
                 if not jugadalot.save 
                   flag_procesamiento_ok = false # algun error guandando registro
                   razon << "salvando acierto positivo al color de la cinta,"
                 end
              else  
                 jugadalot.acierto = "negativo"
                 if not jugadalot.save 
                   flag_procesamiento_ok = false # algun error guandando registro
                   razon << "salvando acierto negativo al color de la cinta,"
                 end  

              end
          end   
        end # end del each do lopp condition ok
      end # end de if not condtion ok



      #Calcular aciertos positivos a menos tiempo:
      @todas_las_jugadas_a_procesar_a_menos_tiempo = Jugadalot.today.where(:pelea => linea_enterrada.pelea, :apuestacinta => "-") # 
      #ejempl hasta aqui todas las de las pelea 11, en el prx each, todas las de las peleas 12, etc...
      #todas ganadoras azul azul, blanco blanco, ACIERTO POSOTIVIO EACH.
      if not @todas_las_jugadas_a_procesar_a_menos_tiempo.empty? # si existen, actualizar como aciertos positivos
        @todas_las_jugadas_a_procesar_a_menos_tiempo.each do |jugadalot|
          #verificar condicion a menos tiempo antes de marcar como acierto positivo: 
          if ( (tiempofinalizado.to_f < tiempoml.to_f) && (linea_enterrada.resultado != "nula") && ( linea_enterrada.resultado != "tabla" ) ) # Y que la pelea no sea nula ni tabla condirerar tambien.
            jugadalot.acierto = "positivo"
            if not jugadalot.save 
              flag_procesamiento_ok = false # algun error guandando registro
              razon << "salvando acierto a menos tiempo,"
            end
          else
            jugadalot.acierto = "negativo"
            if not jugadalot.save 
              flag_procesamiento_ok = false # algun error guandando registro
              razon << "salvando acierto negativo a menos tiempo,"
            end
          end
        end
      end



      #Calcular aciertos positivos a mas tiempo:
      @todas_las_jugadas_a_procesar_a_mas_tiempo = Jugadalot.today.where(:pelea => linea_enterrada.pelea, :apuestacinta => "+") # 
      #ejempl hasta aqui todas las de las pelea 11, en el prx each, todas las de las peleas 12, etc...
      #todas ganadoras azul azul, blanco blanco, ACIERTO POSOTIVIO EACH.
      if not @todas_las_jugadas_a_procesar_a_mas_tiempo.empty? # si existen, actualizar como aciertos positivos
        @todas_las_jugadas_a_procesar_a_mas_tiempo.each do |jugadalot|
          #verificar condicion a mas tiempo antes de marcar como acierto positivo: 
         if ( (tiempofinalizado.to_f > tiempoml.to_f) && (linea_enterrada.resultado != "nula") && ( linea_enterrada.resultado != "tabla" ) ) # Y que la pelea no sea nula ni tabla condirerar tambien.
          jugadalot.acierto = "positivo"
          if not jugadalot.save 
            flag_procesamiento_ok = false # algun error guandando registro
            razon << "salvando acierto a mas tiempo,"
          end
        else
          jugadalot.acierto = "negativo"
          if not jugadalot.save 
            flag_procesamiento_ok = false # algun error guandando registro
            razon << "salvando acierto negativo a mas tiempo,"
          end
         end
        end
      end
  
    end # end del bloque pelean enterradas ok @lineas_enterradas.each do |linea_enterrada|

    
      
     #Verificar Tablas y Nulas para recalcular parlays y posible pago real:
     
     #Actualizar condicion NULA de jugada  a empate  a todos las jugadas que pertenezcan a una pelea nula
      @lineas_peleas_nulas.each do |lineas_peleas_nula|
        @todas_las_jugadas_a_procesar_empate_por_condicion_nula = Jugadalot.today.where(:pelea => lineas_peleas_nula.pelea)
        #ejempl hasta aqui todas las de las pelea 11, en el prx each, todas las de las peleas 12, etc...
        #todas ganadoras azul azul, blanco blanco, ACIERTO POSOTIVIO EACH.
        if not @todas_las_jugadas_a_procesar_empate_por_condicion_nula.empty? # si existen, actualizar como aciertos positivos
          @todas_las_jugadas_a_procesar_empate_por_condicion_nula.each do |jugadalot|
            jugadalot.acierto = "empate"
            if not jugadalot.save 
              flag_procesamiento_ok = false # algun error guandando registro
              razon << "salvando acierto a empate,"
            end
          end
        end
      end # fin del bloque  @lineas_peleas_nulas.each do |lineas_peleas_nula|

      #Actualizar condicion TABLA de jugada  a empate  a todos las jugadas que pertenezcan a una pelea Tabla
      @lineas_peleas_tabla.each do |lineas_peleas_tabla|
        @todas_las_jugadas_a_procesar_empate_por_condicion_tabla = Jugadalot.today.where(:pelea => lineas_peleas_tabla.pelea)
        #ejempl hasta aqui todas las de las pelea 11, en el prx each, todas las de las peleas 12, etc...
        #todas ganadoras azul azul, blanco blanco, ACIERTO POSOTIVIO EACH.
        if not @todas_las_jugadas_a_procesar_empate_por_condicion_tabla.empty? # si existen, actualizar como aciertos positivos
          @todas_las_jugadas_a_procesar_empate_por_condicion_tabla.each do |jugadalot|
            jugadalot.acierto = "empate"
            if not jugadalot.save 
              flag_procesamiento_ok = false # algun error guandando registro
              razon << "salvando acierto empate por tabla,"
            end
          end
        end
      end # fin del bloque  @lineas_peleas_tablas.each do |lineas_peleas_tabla|


   

    #Recalcular parlay de Tickets con jugadas con empate

    #   Tickets y Jugadas con empate
    #   Un ticket es ganador si comple con cualquiera de estas situaciones
    #A)Todas sus jugadas son aciertos positivos
    #B)Todas las jugadas son empates => ganador (Devolucion del dinero y autodescuento de la venta como ticket ganador ) ok
    #C)Todas sus jugadas son solo aciertdos positivos o empate. RECALCULAR PARLAYS con las empate ok.
    
    #calcular_parlay_con_empate
    
    #A) Todos los aciertos porisitvos:

    @contador_aciertos_positivos = 0
    @contador_aciertos_negativos = 0
    @contador_aciertos_empate =    0
    @contador_aciertos_pendiente = 0
    @contador_aciertos_en_blanco = 0

    @tickets_de_hoy =  Ticket.today.where(:activo => "si") # todos los ticket activos de hoy
    #verificar jugadas de los tickets (aqui ya tienen los aciertos definidos)
    @tickets_de_hoy.each do |ticket|
      #verificar las jugdas de ese ticket
      @jugadas_de_ese_ticket = Jugadalot.today.where(:ticket_id => ticket.id)
      #verificar aciertos de ese ticket:
      #resetear contadores
      @contador_aciertos_positivos = 0
      @contador_aciertos_negativos = 0
      @contador_aciertos_empate =    0
      @contador_aciertos_pendiente = 0
      @contador_aciertos_en_blanco = 0

      @jugadas_de_ese_ticket.each do |jugada|
        #bucar aciertos positivo, negativo, empate y pendiente
        if jugada.acierto == "positivo"
          @contador_aciertos_positivos +=1
        end
        if jugada.acierto == "negativo"
          @contador_aciertos_negativos +=1
        end
        if jugada.acierto == "empate"
          @contador_aciertos_empate +=1
        end
        if jugada.acierto == "pendiente"
          @contador_aciertos_pendiente +=1
        end
        if jugada.acierto == ""
          @contador_aciertos_en_blanco +=1
        end



        #todos los aciertos positivos: ganador
        if ( ( @jugadas_de_ese_ticket.size == @contador_aciertos_positivos ) && ( @contador_aciertos_positivos > 0 ))
          #ticket.pagoreal = ticket.pago # la misma cantidad a pagar ok
          ticket.pagoreal = Jugadalot.where(:ticket => ticket.id).last.posiblepago # EL pago real sera el posible pago porque todas con aciertos positivos computaods. El paro real cambia es en condiciones de empates o tabla u otro factor diferente ok. ted

          ticket.ganador = "si" # todos aciertos posivitos ok.
          if not ticket.save
            flag_procesamiento_ok = false 
            razon << "salvando ticket ganador todos los aciertos,"
          end

        end

        #todos los aciertos empate: ganador
        if ( ( @jugadas_de_ese_ticket.size == @contador_aciertos_empate ) && ( @contador_aciertos_empate > 0 ))
          #ticket.pagoreal = ticket.pago # la misma cantidad a pagar ok
          ticket.pagoreal = Jugadalot.where(:ticket => ticket.id).last.monto # Se devuelte el monto del dinero apostado, no el posible pago recalculado porque es empate, devolucion del dinero venta ok.
          ticket.ganador = "si" # todos aciertos posivitos ok.
          if not ticket.save
            flag_procesamiento_ok = false 
            razon << "salvando ticket ganador todos empate,"
          end

        end

        #todos los aciertos son positivos o empate y ambos diferente de cero (evitar directos y  evitar 1+0 o 0+1 ok) : recalcular y ganador
        if( (@contador_aciertos_positivos > 0) &&  (@contador_aciertos_empate > 0) )
          if (@jugadas_de_ese_ticket.size == (@contador_aciertos_positivos + @contador_aciertos_empate) )
            #recalcular ticket, setear ganador y con nuevo pago real ok.
            #recalcular
            #ticket.pagoreal = ticket.pago # la misma cantidad a pagar ok


            #Sacar le motno del ticket de manera manual del modelo Jugadalot, la ultima jugada del ticket activo tiene el monto y el posible pago del ticket ok ted:
            @special_ticket_id = ticket.id

            @special_ticket       = Jugadalot.today.where(:ticket_id => ticket.id).last || [] # cero provisional el monto klk?
            @special_ticket_monto = @special_ticket.monto || 0


            posible_pago = procesar_posible_pago_recalcular_parlay(@special_ticket_id , @special_ticket_monto) #  posible pago del ticket completo, diferente a pago real, depende si hay empates o nulos computados ok.. la funcion retorna nil, o array con 3 elementos ok

            #posible_pago[ apostado, ganacia, a cobrar ]

            #********************************
            apostado = posible_pago[0]
            ganancia = posible_pago[1] 
            acobrar =  posible_pago[2] 
            #********************************
                  
            ticket.pagoreal = acobrar# la misma cantidad a pagar ok
            ticket.ganador = "si" # todos aciertos posivitos ok.
            if not ticket.save
            flag_procesamiento_ok = false 
            razon << "salvando ticket ganador recalculado con Pago Real,"
            end


            #No necesario lo de bajo ok.
            # @last_jugada = jugadas.last # elijo el ultimo elemnto del array de jugadads del ticket actual para poner el posible pago y monto del conjunto de jugadas que conforman ese ticket. ok. sacado de arriba, justo debajo del when, de esta line a de codigo ok:   Jugadalot.where(:ticket_id => last_tickect_current_user)
            #@last_jugada.monto = apostado
            # @last_jugada.pagoreal = acobrar # reasignacion del monto ganador real ok.

          end # if (@jugadas_de_ese_ticket.size == (@contador_aciertos_positivos + @contador_aciertos_empate) )
        end # if( (@contador_aciertos_positivos > 0) &&  (@contador_aciertos_empate > 0) )
      end # @jugadas_de_ese_ticket.each do |jugada|  
    end # @tickets_de_hoy.each do |ticket|


    #Marcar los ticket perdedores test:
    #Definicion: Un ticket es perdedor si esta activo y tiene al menos un acerto negativo como condicion.
    @id_tickets_con_aciertos_negativos = Jugadalot.today.where(:acierto => "negativo").group(:ticket_id).count.keys
    #Marcarlos:
    @id_tickets_con_aciertos_negativos.each do |id_tk|
      ticket = Ticket.find(id_tk) 
      ticket.ganador = "no"
      if not ticket.save
            flag_procesamiento_ok = false 
            razon << "Error salvando condicion de ticket perdedor en procesamiento,"
      end
      
    end



    st = "OK, PROCESAMIENTO FINALIZADO OK."

    if flag_procesamiento_ok == false
       st = "X FALLIDO, Intente de nuevo or contact Support" + razon.to_s
    end

    redirect_to "/lineats", notice: "STATUS PROCESADO: #{st}."and return 
    #notas: Si una nula hay que recalcular pagoreal y si hay una tabla tambien, hay que recalcular ok. Ej. tripela se convierte en pale con posible pago real ok.

  end # fin del controlador def procesar_resultados.



  private



  def procesar_posible_pago_recalcular_parlay(jugadalot, monto)
    entrada  = monto
    apostado = monto.to_f
    
    jugadas  =  Jugadalot.today.where(:ticket_id => jugadalot, :acierto => "positivo") || [] # solo las jugadas con acirteos positivos para recalcular el asunto a pago real ok.
    
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


    # Use callbacks to share common setup or constraints between actions.
    def set_lineat
      @lineat = Lineat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lineat_params
      params.require(:lineat).permit(:coliseo, :bloque, :pelea, :azul, :blanco, :mla, :mlb, :tiempoml, :oua, :oub, :status, :resultado, :tiempofinalizado)
    end

end
