class MenuadmrresultadoglobalxsupervisortsController < ApplicationController

  def index
    # @primero = ganadores.primero < 10 ? ("0" + ganadores.primero.to_s) : ganadores.primero.to_s
    session[:fecha_venta_dia_1].values[2] = session[:fecha_venta_dia_1].values[2].to_i < 10 ? (session[:fecha_venta_dia_1].values[2] = "0" + session[:fecha_venta_dia_1].values[2] ) : (session[:fecha_venta_dia_1].values[2])
    session[:fecha_venta_dia_2].values[2] = session[:fecha_venta_dia_2].values[2].to_i < 10 ? (session[:fecha_venta_dia_2].values[2] = "0" + session[:fecha_venta_dia_2].values[2] ) : (session[:fecha_venta_dia_2].values[2])

    @dia1 = session[:fecha_venta_dia_1].values.reverse.join("-") # hash.values retorna array. para la consulta de by_day(fehca en ingles yyyy-mm-dd)    
    @dia2 = session[:fecha_venta_dia_2].values.reverse.join("-")
    @supervisor_id = session[:supervisor_id].values[0]  # porque el permited params lo manda como hash {key, value}

    # lo sigeuinte es para evitar que el 31-10-2018 sea mayor que el 01-11-2018 en la comparacion de fecha.to_i (agregar 0 deciumal que falta en noviembre)
    #@dia1 => "2018-10-31" 
    @day = @dia2.split("-")[2].to_i < 10 ? "0"+@dia2.split("-")[2] : @dia2.split("-")[2]
    ymd = @dia2.split("-")
    ymd[2] = @day
    @dia2 = ymd.join("-")

    # Lo mismo pada dia1 porque tambien tiene el mismo error. 5 => 05 ok.
    @day = @dia1.split("-")[2].to_i < 10 ? "0"+@dia1.split("-")[2] : @dia1.split("-")[2]
    ymd = @dia1.split("-")
    ymd[2] = @day
    @dia1 = ymd.join("-")


    if @dia1.split("-").join("").to_i > @dia2.split("-").join("").to_i
       redirect_to "/menuadmrresultadoglobalxsupervisorts/new", notice: "Fecha final debe se mayor a la fecha de inicio." and return
    end

    y, m, d = @dia2.to_s.split("-")

    if not (Date.valid_date? y.to_i, m.to_i, d.to_i) # sacado de link: https://stackoverflow.com/questions/2955830/how-to-check-if-a-string-is-a-valid-date
      redirect_to "/menuadmrresultadoglobalxsupervisorts/new", notice: "Debe elegir una fecha final valida. Ej. favor verifiicar si el mes es de 30 o 31 dias." and return
    end

    y, m, d = @dia1.to_s.split("-")
    
    if not (Date.valid_date? y.to_i, m.to_i, d.to_i) # sacado de link: https://stackoverflow.com/questions/2955830/how-to-check-if-a-string-is-a-valid-date
      redirect_to "/menuadmrresultadoglobalxsupervisorts/new", notice: "Debe elegir una fecha de inicio valida. Ej. favor verifiicar si el mes es de 30 o 31 dias." and return
    end

    @dia2 = @dia2.to_date.tomorrow # + 1.day    #como en between simepre empieza al inicio del dia, o sea a la media noche, La fecha final le sumaremos un dia para que seal igual al final del dia elegido, que es igual al inicio del dia posterior al final deseado. O sea, desde inicio de A hasta inicio de C es igual a: Desde inicio de a hasta final de B. (Donde termina B empieza C) ok. Ted. Rails concole. ok.

      
      @total_sucursales = 0
      @total_ventas = 0.to_i
      @total_ganadores = 0.to_i
      @total_balance = 0.to_i
      @total_pendientexpagar = 0.to_i
      
      a=[] 

      @supervisor_object = Supervisort.find(@supervisor_id)
      @supervisor = @supervisor_object.nombre + " " + @supervisor_object.apellido # Nombre y apellido del supervisor ara mostrarlo en la vista de este controlador. (inde.html.erb) ok. ted.

      User.where(:supervisort_id => @supervisor_object.id ).order(:email).each do |user| # en un furuto: User.where(:tipousuario => 'ventas')...etc
          @line = Menuadmrresultadoglobalxsupervisort.new # =>  Menuadmrresultadoglobalxsupervisort objetc.
          @line.sucursal = user.email.split("@")[0].to_s
          
          @conjunto_elementos = Jugadalot.between_times(@dia1.to_date , @dia2 ).where(:ticket_id => Ticket.between_times(@dia1.to_date , @dia2 ).where(:user_id => user.id , :activo => "si").ids ) # eliminamos .sum (:monto) poruqe postgres no sume stings ok
           #realizaremos la sumatoria manual porque postgres no suma string:

          if not @conjunto_elementos.nil?

             @conjunto_elementos.each do | jugada |
              @line.venta += jugada.monto.to_i # sumatoria manual de los montos de esas jugadas ok.  
             end

          end


          
         
          #@line.ganadores = Ticketsganadorest.between_times(@dia1.to_date , @dia2 ).where(:ticket_id => Ticket.between_times(@dia1.to_date , @dia2 ).where(:user_id => user.id , :activo => "si").ids ).sum(:montoacobrar)
          @conjunto_elementos_tickets =  Ticket.between_times(@dia1.to_date , @dia2 ).where( :user_id => user.id, :id => [Ticket.where(:ganador => "si").ids])# manual por error de postgres sting ok .sum(:pagoreal) # ordenar por usuario para luego hacer la r         

           if not @conjunto_elementos_tickets.nil? 

             @conjunto_elementos_tickets.each do | ticket |
              @line.ganadores += ticket.pagoreal.to_i # sumatoria manual de los montos de esas jugadas ok.  
             end

          end







         # @line.pendientexpagar = Ticket.between_times(@dia1.to_date , @dia2 ).where(:id => [Ticket.where( :user_id => user.id, :activo => "si", :ganador => "si", :pago => nil).ids]).sum(:pagoreal) # ordenar por usuario para luego hacer la referencia a la sucursal tambien ok
           @conjunto_elementos_pdtes_x_pagar = Ticket.between_times(@dia1.to_date , @dia2 ).where(:id => [Ticket.where( :user_id => user.id, :activo => "si", :ganador => "si", :pago => nil).ids]) # manual por el srror de posgtres string ok sum(:pagoreal) # ordenar por usuario para luego hacer la referencia a la sucursal tambien ok


           if not @conjunto_elementos_pdtes_x_pagar.nil?

             @conjunto_elementos_pdtes_x_pagar.each do | ticket |
               @line.pendientexpagar += ticket.pagoreal.to_i # sumatoria manual de los montos de esas jugadas ok.  
             end

          end


          #control manual de errores operando con nil elements
          if @line.venta.nil?
            @line.venta = 0
          end

          if @line.ganadores.nil?
            @line.ganadores = 0
          end





          @line.balance = @line.venta - @line.ganadores
          a << @line
          
          @total_sucursales +=1
          @total_ventas += @line.venta.to_i
          @total_ganadores += @line.ganadores.to_i
          @total_pendientexpagar  += @line.pendientexpagar.to_i
      end
    


      @menuadmrresultadoglobalxsupervisorts = a
     
      @total_balance = @total_ventas - @total_ganadores

    



    @dia1 = session[:fecha_venta_dia_1].values.join("-") # para el show dd-mm-aaaa
    @dia2 = session[:fecha_venta_dia_2].values.join("-") # para el show dd-mm-aaaa

   # session[:fecha_venta_dia] = nil
    
    @st = ""
    @font = "|2C" # Tamanio de las letras.

    @data = "" # Hacer un espacion para la separacion del titulo. Estetica del reporte. ok ted.
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    @data = "Reporte de Venta:" 
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    @data = "" # Hacer un espacion para la separacion del titulo. Estetica del reporte. ok ted.
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    @dia1 = session[:fecha_venta_dia_1].values.join("-")
    @dia2 = session[:fecha_venta_dia_2].values.join("-")

    @data = "Desde: " + @dia1.to_s # aqui tiene este valor: @dia = session[:fecha_venta_dia].values.join("-")
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"
    

    @data = "Hasta: " + @dia2.to_s # aqui tiene este valor: @dia = session[:fecha_venta_dia].values.join("-")
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"
    

    @data = "Sucursal: " + current_user.email.split("@")[0].to_s
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"
    
    
    #@data = "Venta: $" + @valor.to_s # number_to_currency(@valor, :unit => "", :delimiter => ",", :precision => 0, :separator => ".")
    
    @data = "Venta: $" + ActionController::Base.helpers.number_to_currency(@valor.to_s, :unit => "", :delimiter => ",", :precision => 0, :separator => ".")
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    @data = "" # Hacer un espacion para la separacion del titulo. Estetica del reporte. ok ted.
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    @font = "|1C"
    @data = "Consultado el: " + Time.now.strftime("%d/%m/%Y (%H:%M:%S)").to_s 
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    @data = "" # Hacer un espacion para la separacion del titulo. Estetica del reporte. ok ted.
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    session[:fecha_venta_dia_1] = nil # Limpio la variable para evitar cookie oversize en el cliente.
    session[:fecha_venta_dia_2] = nil # Limpio la variable para evitar cookie oversize en el cliente.
   


  end

  def show
  end

  def new
    @menuadmrresultadoglobalxsupervisort = Menuadmrresultadoglobalxsupervisort.new
  end

  def edit
  end

  def create
    @fecha1 = params.require(:menuadmrresultadoglobalxsupervisort).permit(:desde) 
    @fecha2 = params.require(:menuadmrresultadoglobalxsupervisort).permit(:hasta)
    @supervisor_id = params.require(:menuadmrresultadoglobalxsupervisort).permit(:supervisor) # => supervisort.id  del selct rails helper 
    session[:fecha_venta_dia_1] = @fecha1
    session[:fecha_venta_dia_2] = @fecha2
    session[:supervisor_id] = @supervisor_id
    redirect_to menuadmrresultadoglobalxsupervisorts_path and return 
  end

  def update
  end

  def destroy
  end

  private

  def menuadmrresultadoglobalxsupervisort_params
        params.require(:menuadmrresultadoglobalxsupervisort).permit!
  end

end
