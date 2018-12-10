class JugadalotsController < ApplicationController
  before_action :set_jugadalot, only: [:edit, :update, :destroy]
  before_action :verificar_reconexion_de_usuario # Esto si el usuario esta loggeado desde ayer o mas viejo y si tiene cosas pendientes... etc.. session destroy y forzar login.

  # GET /jugadalots
  # GET /jugadalots.json
  
  def index
     # @jugadalots = Jugadalot.all
     if current_user #Verificar id y tipo de cliente que solicita (esto para ver si es cliete celular app, para modificar la vista html de presentacion mejor para la app ok ted.)
      session[:cliente_id] = params['cliente_id'] # params.permit(:tipo_cliente) #params['cliente_id'] #require(:ciudadt).permit(:cliente_id)
      session[:tipo_cliente]  = params['tipo_cliente'] # "klk" # params['tipo_cliente'] # params.require(:ciudadt).permit(:tipo_cliente)
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


  end

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


    #case ...
      #Aqui va la logica del controller. 

    #end


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
    params.require(:jugadalot).permit(:ticket, :n1, :n2, :n3, :monto, :qpt, :sorteo, :cliente_id, :tipo_cliente)
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