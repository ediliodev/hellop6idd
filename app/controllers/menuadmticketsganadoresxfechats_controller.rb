class MenuadmticketsganadoresxfechatsController < ApplicationController
 

 
  def index
     # @primero = ganadores.primero < 10 ? ("0" + ganadores.primero.to_s) : ganadores.primero.to_s
    session[:fecha_venta_dia_1].values[2] = session[:fecha_venta_dia_1].values[2].to_i < 10 ? (session[:fecha_venta_dia_1].values[2] = "0" + session[:fecha_venta_dia_1].values[2] ) : (session[:fecha_venta_dia_1].values[2])
    session[:fecha_venta_dia_2].values[2] = session[:fecha_venta_dia_2].values[2].to_i < 10 ? (session[:fecha_venta_dia_2].values[2] = "0" + session[:fecha_venta_dia_2].values[2] ) : (session[:fecha_venta_dia_2].values[2])

    @dia1 = session[:fecha_venta_dia_1].values.reverse.join("-") # hash.values retorna array. para la consulta de by_day(fehca en ingles yyyy-mm-dd)    
    @dia2 = session[:fecha_venta_dia_2].values.reverse.join("-")

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
       redirect_to "/menuadmticketsganadoresxfechats/new", notice: "Fecha final debe se mayor a la fecha de inicio." and return
    end

    y, m, d = @dia2.to_s.split("-")

    if not (Date.valid_date? y.to_i, m.to_i, d.to_i) # sacado de link: https://stackoverflow.com/questions/2955830/how-to-check-if-a-string-is-a-valid-date
      redirect_to "/menuadmticketsganadoresxfechats/new", notice: "Debe elegir una fecha final valida. Ej. favor verifiicar si el mes es de 30 o 31 dias." and return
    end

    y, m, d = @dia1.to_s.split("-")
    
    if not (Date.valid_date? y.to_i, m.to_i, d.to_i) # sacado de link: https://stackoverflow.com/questions/2955830/how-to-check-if-a-string-is-a-valid-date
      redirect_to "/menuadmticketsganadoresxfechats/new", notice: "Debe elegir una fecha de inicio valida. Ej. favor verifiicar si el mes es de 30 o 31 dias." and return
    end

    @dia2 = @dia2.to_date.tomorrow # + 1.day    #como en between simepre empieza al inicio del dia, o sea a la media noche, La fecha final le sumaremos un dia para que seal igual al final del dia elegido, que es igual al inicio del dia posterior al final deseado. O sea, desde inicio de A hasta inicio de C es igual a: Desde inicio de a hasta final de B. (Donde termina B empieza C) ok. Ted. Rails concole. ok.


    #@valor = Jugadalot.between_times(@dia1.to_date , @dia2 ).where(:ticket_id => Ticket.between_times(@dia1.to_date , @dia2 ).where(:user_id => current_user.id , :activo => "si").ids ).sum(:monto)

    @ticketsganadorestsxfechat = Ticketsganadorest.between_times(@dia1.to_date , @dia2 ).where(:ticket_id => [Ticket.where(:ganador => "si", :pago => nil).ids]).order(:sucursal)



    @dia1 = session[:fecha_venta_dia_1].values.join("-") # para el show dd-mm-aaaa
    @dia2 = session[:fecha_venta_dia_2].values.join("-") # para el show dd-mm-aaaa



    session[:fecha_venta_dia_1] = nil # Limpio la variable para evitar cookie oversize en el cliente.
    session[:fecha_venta_dia_2] = nil # Limpio la variable para evitar cookie oversize en el cliente.
    
  end

  
  def show
  end

  # GET /menuadmticketsganadoresxfechats/new
  def new
    @menuadmticketsganadoresxfechat = Menuadmticketsganadoresxfechat.new
  end

  def edit
  end


  def create
    @fecha1 = params.require(:menuadmticketsganadoresxfechat).permit(:desde) 
    @fecha2 = params.require(:menuadmticketsganadoresxfechat).permit(:hasta) 
    session[:fecha_venta_dia_1] = @fecha1
    session[:fecha_venta_dia_2] = @fecha2
    redirect_to menuadmticketsganadoresxfechats_path and return 
  end

  
  def update
  end

  
  def destroy 
  end

  private
   

    # Never trust parameters from the scary internet, only allow the white list through.
    def menuadmticketsganadoresxfechat_params
      params.require(:menuadmticketsganadoresxfechat).permit(:sucursal, :desde, :hasta)
    end
end



###--------------------
