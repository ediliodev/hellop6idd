class GanadorestsController < ApplicationController
  before_action :set_ganadorest, only: [:show, :edit, :update, :destroy]

  # GET /ganadorests
  # GET /ganadorests.json
  def index
    @ganadorests = Ganadorest.all
  end

  # GET /ganadorests/1
  # GET /ganadorests/1.json
  def show
  end

  # GET /ganadorests/new
  def new
    @ganadorest = Ganadorest.new
  end

  # GET /ganadorests/1/edit
  def edit
  end

  # POST /ganadorests
  # POST /ganadorests.json
  def create 

   @ganadorest = Ganadorest.new(ganadorest_params)
   #Verificar que el sorteo este cerrado para procesar los ganadores, o cerrarlo automaticamente (Para que no hallans mas ticket. Nota: Si la Hora sorteo es menor que la hora actual, tambie se cierra automaticamente al intentar hacer un ticket. El cierre por aqui es por si los resultados salen o se computan antes del cierre por hora. ok.)
   #Verificar sorteo cerrado o cerrarlo:
   @sorty = Sorteot.find(@ganadorest.sorteot_id) # ID
   
   if ( @sorty && @sorty.abierto != "no")
       @sorty.abierto = "no"
       @sorty.save  # Cierro el sorteo para procesar ganadores y reportes. No se permiten mas tickets.
   end

   # @ganadorest.fecha  => datetime

    @ganadorest.fecha  =  (@ganadorest.fecha - 4.hours).to_date.to_time # Esto para evitar que los ganadores de la noche 09:00pm salgan con fecha de consulta de mananaa 9+ 4 GMT =  1am del dia sgte. Evitamos eso. ok ted. y lugeo en /g consultar ganadores salgan bien con Time.now.to_date. Ya que active record guarda los datetime en formato GMT00 en la bdatos. ok ted.
   # Guardar los Ganadorests
    if @ganadorest.save!
      # @ganadorest => sorteo, fecha, primero, segundo, tercero 
      @sorteo  = @ganadorest.sorteot.sigla
      
      @modelo_actual = Aliasmodelosiglasorteot.where(:siglasorteo =>  @sorteo).first # => aliasmodelosiglasorteot ID  nombre  siglasorteo:string modeloventaq:string modelocontrolq:string modeloventap:string modelocontrolp:string modeloventat:string modelocontrolt:string modeloventasp:string  modelocontrolsp:string

      if @modelo_actual == nil
         redirect_to "/ganadorests/new", notice: "X No se pudo procesar porque este sorteo no tiene definido el alias (Aliasmodelosiglasorteot) para el reset de disponibilidad. Favor contactar soporte." and return 
      end
      
      @fecha   = @ganadorest.fecha
      @primero = @ganadorest.primero
      @segundo = @ganadorest.segundo
      @tercero = @ganadorest.tercero
      @grupo_procesado_datetime = Time.now # Esto para poner la hora y fecha de los ganadores procesados. ok ted.
      @grupo_procesado = @grupo_procesado_datetime.to_i.to_s # es un numero de control en string para marcar todos los procesados, en caso que un dia haya que modificar los ganadores y borrar el grupo procesado para reingresar y computar nuevamente en caso de error. ok ted.
      
      @grupo_procesado_datetime = @grupo_procesado_datetime.strftime("%d/%m/%y - %H:%M:%S").to_s

    
    #Ejecuto normal siempre y cuando no sea un super pale. (Ya que el super pale no computa quinielas ni tripletas) De lo contrario, es un sp, salto el bloque y sigo debajo del if end condition. ok. ted.

    if (@sorteo.to_i != 13 && @sorteo.to_i != 14  && @sorteo.to_i != 17 )

      #procesar los ganadores de: QUINIELA, PALE Y TRIPLETAS DE ESE SORTEOOOOO OK TED.
      #quinielas:
      encontrar_y_procesar_ganadores_quiniela(@sorteo, @fecha.to_date, @primero, 1 , @grupo_procesado) # Computar ganadores quinielas con el primer premio  - params a enviar:  sorteot , fecha , numero_segun_cardinalidad , cardinalidad 
      encontrar_y_procesar_ganadores_quiniela(@sorteo, @fecha.to_date, @segundo, 2 , @grupo_procesado) # Computar ganadores quinielas con el segundo premio
      encontrar_y_procesar_ganadores_quiniela(@sorteo, @fecha.to_date, @tercero, 3 , @grupo_procesado) # Computar ganadores quinielas con el tercero premio

      #Procesar Pale ganadores (1-2, 1-3, 2-3) de ese sorteo:
      #definir la funcion (pdte)
      encontrar_y_procesar_ganadores_pale(@sorteo, @fecha.to_date, @primero, @segundo, "p12" , @grupo_procesado) # Computar ganadores quinielas con el primer premio  - params a enviar:  sorteot , fecha , numero_segun_cardinalidad , cardinalidad 
      encontrar_y_procesar_ganadores_pale(@sorteo, @fecha.to_date, @primero, @tercero, "p13" , @grupo_procesado) # Computar ganadores quinielas con el primer premio  - params a enviar:  sorteot , fecha , numero_segun_cardinalidad , cardinalidad 
      encontrar_y_procesar_ganadores_pale(@sorteo, @fecha.to_date, @segundo, @tercero, "p23" , @grupo_procesado) # Computar ganadores quinielas con el primer premio  - params a enviar:  sorteot , fecha , numero_segun_cardinalidad , cardinalidad 
      
      #Procesar Tripletas (1-2-3, 1-3, 1-2, 2-3, etc.. ) ganadores de ese sorteo:
      #definir la funcion (pdte)
      #def encontrar_y_procesar_ganadores_tripleta_full sorteot , fecha , n1 , n2, n3  , grupo_procesado
      encontrar_y_procesar_ganadores_tripleta_full(@sorteo, @fecha.to_date, @primero, @segundo, @tercero , @grupo_procesado) # Computar ganadores quinielas con el primer premio  - params a enviar:  sorteot , fecha , numero_segun_cardinalidad , cardinalidad       
      #bucar tripletas semi_full tambien. (SOLO DOS COINCIDENCIAS DE 3, pagan 100 pesos no importa el orden de las dos coincidencias)
      #encontrar_y_procesar_ganadores_tripleta_semi_full(@sorteo, @fecha.to_date, @primero, @segundo, @tercero , @grupo_procesado) # Computar ganadores quinielas con el primer premio  - params a enviar:  sorteot , fecha , numero_segun_cardinalidad , cardinalidad       

      #@tickets_ganadores_en_primera
      #verificar el sorteo
      #verificar la fecha
      #computar resultados en base a ganadores y gpp de cada ticket de cada sucursal. klk.
      #procesar ganadores en ese sorteo de esa fecha en la tabla de ganadores de ese sorteo o global?

      #resetear la disponibilidad en la DB en base al modelo de ese sorteo ingresado.
      #resetar control q, p, t, y sp (pdte) para que esten dispobible todos para la proxima apertura del sorteo.
      @model_control_q = @modelo_actual.modelocontrolq.classify.constantize
      @model_control_q.update_all("vendida = 0"); # reseteo la disponibiliadad de quinielas de ese sorteo. (01-Nacional Noche).

      @model_control_p = @modelo_actual.modelocontrolp.classify.constantize
      @model_control_p.update_all("vendida = 0");

      @model_control_t = @modelo_actual.modelocontrolt.classify.constantize
      @model_control_t.update_all("vendida = 0");

      #Listo para volver a venter q, p y t para la proxima apertura de ese sorteo.

    end

    # verifico aqui si es super pale para procesar esta parte:
    if (@sorteo.to_i == 13 || @sorteo.to_i == 14  || @sorteo.to_i == 17 )

      #Usamos la misa logica de pales pero ahora para sp ok ted.
      encontrar_y_procesar_ganadores_pale(@sorteo, @fecha.to_date, @primero, @segundo, "sp" , @grupo_procesado) 
      @model_control_p = @modelo_actual.modelocontrolp.classify.constantize
      @model_control_p.update_all("vendida = 0");

    end
      
      redirect_to "/ganadorests/new", notice: "Procesado correctamente #{@grupo_procesado_datetime}. OK." + " El Grupo procesado es: " +  @grupo_procesado and return 
    
    else
      redirect_to "/ganadorests/new", notice: "X No se pudo completar el proceso. Favor contactar soporte tecnico de inmediato. " and return 
    end


  end # Fin de la accion.


  # PATCH/PUT /ganadorests/1
  # PATCH/PUT /ganadorests/1.json
  def update
    redirect_to "/ganadorests/", notice: "X No Permitido actualizar ganadores. Favor contactar a su Superior.  " and return 


    respond_to do |format|
      if @ganadorest.update(ganadorest_params)
        format.html { redirect_to @ganadorest, notice: 'Ganadorest was successfully updated.' }
        format.json { render :show, status: :ok, location: @ganadorest }
      else
        format.html { render :edit }
        format.json { render json: @ganadorest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ganadorests/1
  # DELETE /ganadorests/1.json
  def destroy

    redirect_to "/ganadorests/", notice: "X No Permitido Borrar ganadores. Favor contactar a su Superior.  " and return 

    @ganadorest.destroy
    respond_to do |format|
      format.html { redirect_to ganadorests_url, notice: 'Ganadorest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

# DECLARACION DE FUNCIONES PRIVADAS DE ESTE CONTROLLER

  private

  #---------------

  def encontrar_y_procesar_ganadores_tripleta_full sorteot , fecha , n1 , n2, n3 , grupo_procesado
    
      #Listado de sorteos y tablas a buscar en la BD.
      #@hash_sorteos_vs_modelos_record_ventas = {'01' => 'Recordqnnt', '02' => 'Recordqntt' } # etc. define el modelo de venta a buscar la informacion de los ganadores.
  #   @modelo = @hash_sorteos_vs_modelos_record_ventas[sorteot] # => si sigla es '01' hash retorna el nombre del modelo ventas "Recordqnnt" ..ok ted 
  
  #   nueva edicion de lo anterior: 
      @modelo = Aliasmodelosiglasorteot.where(:siglasorteo => sorteot).first.modeloventat
      
      @modelo = @modelo.classify.constantize # Esto para convertir string en constante y poder acceder al modelos de Active Record. Scado de este link: https://stackoverflow.com/questions/34757582/using-variables-for-model-names-in-active-record
      
      #AQUI LUEGO PODEMOS IMPLEMENTAR EL CONCEPTO DE EAGER LOADLING, O SEA CARGAR TODO DE LA FECHA EN UN OBJETO, Y LUEGO LAS CONSULTAS A ESE SOLO OBJETO PARA EVITAR QUERYS A LA BDATOS.
      @tickets_ganadores =  @modelo.by_day(fecha).where(:n1 => n1, :n2 => n2, :n3 => n3)  
      
      #Cotejo las coincidencias de tripletas encontradas como seleccionadas. O sea las de tres numeros como ya seleccionadas para luego seguir buscando las coincidencias de dos elementos de la tripletas (tambien son ganadores pero de 100 pesos por peso apostado (depende del gppt) ok ted.)
      @tickets_ganadores.each do |recordtnnt|
        recordtnnt.seleccionada = "si"
        recordtnnt.save
      end

      @tickets_ganadores =  @modelo.by_day(fecha).where(:n1 => n1, :n2 => n2, :n3 => n3)  # => Ticket, n1, monto (monto apostado, el monto ganador hay que calcularlo con el gpp de la sucursal.)
                            .or( @modelo.by_day(fecha).where(:n1 => n1, :n2 => n3, :n3 => n2) )
                            .or( @modelo.by_day(fecha).where(:n1 => n2, :n2 => n1, :n3 => n3) )
                            .or( @modelo.by_day(fecha).where(:n1 => n2, :n2 => n3, :n3 => n1) )
                            .or( @modelo.by_day(fecha).where(:n1 => n3, :n2 => n2, :n3 => n1) )
                            .or( @modelo.by_day(fecha).where(:n1 => n3, :n2 => n1, :n3 => n2) )
                            .or( @modelo.by_day(fecha).where(:n1 => n1, :n2 => n2, :seleccionada => nil) )
                            .or( @modelo.by_day(fecha).where(:n2 => n1, :n1 => n2, :seleccionada => nil) )
                            .or( @modelo.by_day(fecha).where(:n1 => n1, :n3 => n2, :seleccionada => nil) )
                            .or( @modelo.by_day(fecha).where(:n3 => n1, :n1 => n2, :seleccionada => nil) )
                            .or( @modelo.by_day(fecha).where(:n2 => n1, :n3 => n2, :seleccionada => nil) )
                            .or( @modelo.by_day(fecha).where(:n3 => n1, :n2 => n2, :seleccionada => nil) )
                            .or( @modelo.by_day(fecha).where(:n1 => n1, :n2 => n3, :seleccionada => nil) )
                            .or( @modelo.by_day(fecha).where(:n2 => n1, :n1 => n3, :seleccionada => nil) )
                            .or( @modelo.by_day(fecha).where(:n1 => n1, :n3 => n3, :seleccionada => nil) )
                            .or( @modelo.by_day(fecha).where(:n3 => n1, :n1 => n3, :seleccionada => nil) )
                            .or( @modelo.by_day(fecha).where(:n2 => n1, :n3 => n3, :seleccionada => nil) )
                            .or( @modelo.by_day(fecha).where(:n3 => n1, :n2 => n3, :seleccionada => nil) )                 
                            .or( @modelo.by_day(fecha).where(:n1 => n2, :n2 => n3, :seleccionada => nil) )
                            .or( @modelo.by_day(fecha).where(:n2 => n2, :n1 => n3, :seleccionada => nil) )
                            .or( @modelo.by_day(fecha).where(:n1 => n2, :n3 => n3, :seleccionada => nil) )
                            .or( @modelo.by_day(fecha).where(:n3 => n2, :n1 => n3, :seleccionada => nil) )
                            .or( @modelo.by_day(fecha).where(:n2 => n2, :n3 => n3, :seleccionada => nil) )
                            .or( @modelo.by_day(fecha).where(:n3 => n2, :n2 => n3, :seleccionada => nil) )
                            #Seguimos buscando, ahora buscaremos las combinaciones de solo dos numeros de la tripleta, importa el orden. o sea n1 y n2 || n2 y n1 son ganadores tambien ok. ted.
     
      # Revisar el los tres para primero y segundo:
      

      # Revisar el los tres para primero y tercero:
     

      # Revisar el los tres para segundo y tercero:
     


       @tickets_ganadores.each do |ticket|
         @registro = Ticketsganadorest.new # => id, ticket_id, jugada:string, montoapostado:integer, montoacobrar:integer
         @registro.ticket_id = ticket.ticket.id
         @registro.jugada = ticket.n1.to_s + "-" + ticket.n2.to_s + "-" + ticket.n3.to_s
         
         @registro.sorteo = Sorteot.where(:sigla => sorteot.to_s).first.nombre
         @registro.fechasorteo = fecha.to_date

         @registro.montoapostado = ticket.monto

         if ticket.seleccionada == "si" # (@array << .each etc.. => obect.recordtnnt.seleccionada=="si") tripleta con con tres coincidencias. ok tripleta full.
            @registro.montoacobrar = ticket.monto.to_i * ticket.ticket.user.gppt.t123.to_i # 20,000 por cada peso apostado en tripleta full.
         else
            @registro.montoacobrar = ticket.monto.to_i * ticket.ticket.user.gppt.t13.to_i # 100 por cada peso apostado en tripleta full. (t13 paga igual que las demas t23,t12,t21,rtc.. ok ted.)
         end

         @registro.grupoprocesado = grupo_procesado
         @registro.sucursal = Ticket.find(ticket.ticket.id).user.email.split("@")[0] # Esto para registrar de cual sucursal es este ticket ganador. Solo para consulta rapida por el usuario.ok.
         @registro.save # guardo los ticket ganaodres en la tabla gral de Ticketsganadorest         
       
        #Actualizar el atributo ganador en el modelo Ticket.
        @t = Ticket.find(ticket.ticket.id)
        if @t.activo
          @t.ganador = "si"
          @t.save
        end

       end
       
    
    end    


#-----------------
#---------------

def encontrar_y_procesar_ganadores_pale sorteot , fecha , n1 , n2 , cardinalidad , grupo_procesado
    
      #Listado de sorteos y tablas a buscar en la BD.
      #@hash_sorteos_vs_modelos_record_ventas = {'01' => 'Recordqnnt', '02' => 'Recordqntt' } # etc. define el modelo de venta a buscar la informacion de los ganadores.
  #   @modelo = @hash_sorteos_vs_modelos_record_ventas[sorteot] # => si sigla es '01' hash retorna el nombre del modelo ventas "Recordqnnt" ..ok ted 
  
  #   nueva edicion de lo anterior: 
      @modelo = Aliasmodelosiglasorteot.where(:siglasorteo => sorteot).first.modeloventap
      
      @modelo = @modelo.classify.constantize # Esto para convertir string en constante y poder acceder al modelos de Active Record. Scado de este link: https://stackoverflow.com/questions/34757582/using-variables-for-model-names-in-active-record
      
      @tickets_ganadores = @modelo.by_day(fecha).where(:n1 => n1, :n2 => n2) # => Ticket, n1, monto (monto apostado, el monto ganador hay que calcularlo con el gpp de la sucursal.)
                           .or(@modelo.by_day(fecha).where(:n1 => n2, :n2 => n1)) # Esto para los pales, en caso de que salganganadores 02-20 y 20-02 por ejemplo. encontrar todas las coicidencias.

       @tickets_ganadores.each do |ticket|
         @registro = Ticketsganadorest.new # => id, ticket_id, jugada:string, montoapostado:integer, montoacobrar:integer
         @registro.ticket_id = ticket.ticket.id
         @registro.jugada = ticket.n1.to_s + "-" + ticket.n2.to_s
         @registro.sorteo = Sorteot.where(:sigla => sorteot.to_s).first.nombre
         @registro.fechasorteo = fecha.to_date
         @registro.montoapostado = ticket.monto
         @registro.montoacobrar = calcular_monto_a_cobrar_pale(ticket, ticket.monto, cardinalidad) # ticket contiene user y user gpp para los fines de lugar.
         @registro.grupoprocesado = grupo_procesado
         @registro.sucursal = Ticket.find(ticket.ticket.id).user.email.split("@")[0] # Esto para registrar de cual sucursal es este ticket ganador. Solo para consulta rapida por el usuario.ok.
         @registro.save # guardo los ticket ganaodres en la tabla gral de Ticketsganadorest         
       
        #Actualizar el atributo ganador en el modelo Ticket.
        @t = Ticket.find(ticket.ticket.id)
        if @t.activo
          @t.ganador = "si"
          @t.save
        end

       end
       
    
    end    


#-----------------



    def encontrar_y_procesar_ganadores_quiniela sorteot , fecha , numero_segun_cardinalidad , cardinalidad , grupo_procesado
    
      #Listado de sorteos y tablas a buscar en la BD.
      @hash_sorteos_vs_modelos_record_ventas = {'01' => 'Recordqnnt', '02' => 'Recordqntt' } # etc. define el modelo de venta a buscar la informacion de los ganadores.
    
  #   @modelo = @hash_sorteos_vs_modelos_record_ventas[sorteot] # => si sigla es '01' hash retorna el nombre del modelo ventas "Recordqnnt" ..ok ted 
  
  #   nueva edicion de lo anterior: 
      @modelo = Aliasmodelosiglasorteot.where(:siglasorteo => sorteot).first.modeloventaq
      
      @modelo = @modelo.classify.constantize # Esto para convertir string en constante y poder acceder al modelos de Active Record. Scado de este link: https://stackoverflow.com/questions/34757582/using-variables-for-model-names-in-active-record
      
      @tickets_ganadores = @modelo.by_day(fecha).where(:n1 => numero_segun_cardinalidad)  # => Ticket, n1, monto (monto apostado, el monto ganador hay que calcularlo con el gpp de la sucursal.)
      
       @tickets_ganadores.each do |ticket|
         @registro = Ticketsganadorest.new # => id, ticket_id, jugada:string, montoapostado:integer, montoacobrar:integer
         @registro.ticket_id = ticket.ticket.id
         @registro.jugada = ticket.n1
         @registro.sorteo = Sorteot.where(:sigla => sorteot.to_s).first.nombre
         @registro.fechasorteo = fecha.to_date
         @registro.montoapostado = ticket.monto
         @registro.montoacobrar = calcular_monto_a_cobrar_quiniela(ticket, ticket.monto, cardinalidad) # ticket contiene user y user gpp para los fines de lugar.
         @registro.grupoprocesado = grupo_procesado
         @registro.sucursal = Ticket.find(ticket.ticket.id).user.email.split("@")[0] # Esto para registrar de cual sucursal es este ticket ganador. Solo para consulta rapida por el usuario.ok.
         @registro.save # guardo los ticket ganaodres en la tabla gral de Ticketsganadorest         
       
        #Actualizar el atributo ganador en el modelo Ticket.
        @t = Ticket.find(ticket.ticket.id)
        if @t.activo
          @t.ganador = "si"
          @t.save
        end

       end
       
    
    end

    #-----------------------------------

    def calcular_monto_a_cobrar_pale(ticket, montoapostado, cardinalidad) 
      #buscar el gpp de esa sucursal para ganadores en quiniela en primer lugar:
      if cardinalidad == "p12"
          @factor_multipicativo_gpp = ticket.ticket.user.gppt.p12
      end

      if cardinalidad == "p13"
          @factor_multipicativo_gpp = ticket.ticket.user.gppt.p13
      end

      if cardinalidad == "p23"
          @factor_multipicativo_gpp = ticket.ticket.user.gppt.p23
      end

      if cardinalidad == "sp"
          @factor_multipicativo_gpp = ticket.ticket.user.gppt.sp
      end

      montoapostado *  @factor_multipicativo_gpp.to_i

    end

    #-----------------------------------


    def calcular_monto_a_cobrar_quiniela(ticket, montoapostado, cardinalidad) 
      #buscar el gpp de esa sucursal para ganadores en quiniela en primer lugar:
      if cardinalidad == 1
          @factor_multipicativo_gpp = ticket.ticket.user.gppt.q1
      end

      if cardinalidad == 2
          @factor_multipicativo_gpp = ticket.ticket.user.gppt.q2
      end

      if cardinalidad == 3
          @factor_multipicativo_gpp = ticket.ticket.user.gppt.q3
      end

      montoapostado *  @factor_multipicativo_gpp.to_i

    end


    # Use callbacks to share common setup or constraints between actions.
    def set_ganadorest
      @ganadorest = Ganadorest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ganadorest_params
      params.require(:ganadorest).permit(:sorteot_id, :fecha, :primero, :segundo, :tercero)
    end
end
