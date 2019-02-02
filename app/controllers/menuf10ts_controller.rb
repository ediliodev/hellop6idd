class Menuf10tsController < ApplicationController

  
  def index

    #OJO EN FURUTO PENDIENTE CERRAR EL SORTEO (@sorteot_id) DEL CUAL SE TIRA EL REPORTE DE F10. OK TED. PDTE.
   
    @dia = session[:fecha_f10].values.reverse.join("-") # para la consulta de by_day(fehca en ingles yyyy-mm-dd)    
    @sorteot_id = session[:sorteot_f10]
    @sorteot_f10_nombre = Sorteot.where( :id => @sorteot_id ).first.nombre # Esto para la vista del index, nombre del sorteo del reporte @sorteot_f10_nombre.  ok ted.


    #@fecha_sin_cero_izq = session[:fecha_f10].values.join("-") #string
    
    @semi_fecha =  session[:fecha_f10].values # []

    if @semi_fecha[0].to_i < 10 # dia
      @semi_fecha[0] = "0" + @semi_fecha[0].to_s
      #cambiar formtdo de los ceroe en un futuro si deseas...
    end

     if @semi_fecha[1].to_i < 10 # mes
      @semi_fecha[1] = "0" + @semi_fecha[1].to_s
      #cambiar formtdo de los ceroe en un futuro si deseas...
    end


    @dia_formato_rd = @semi_fecha.join("-") # Esto para la vista index del reporte, feche en formato rd ok. dd-mm-aaa.

   # @dia = "2018/12/03"
   # @sorteot_id = 5
    @f10 = []
    #@f10 = Jugadalot.by_day(@dia).where(:ticket_id => Ticket.by_day(@dia).where(:activo => "si").ids, :sorteot_id => Sorteot.where(:sigla => Sorteot.find( @sorteot_id).sigla.to_s ) ).order(:ticket_id)
    @f10 = Jugadalot.by_day(@dia).where(:ticket_id => Ticket.by_day(@dia).where(:activo => "si").ids, :sorteot_id => @sorteot_id ).order(:ticket_id)

  end

  
  def show
  end

  def new
    @menuf10t = Menuf10t.new
  end

  def edit
  end

  
  def create
    @fecha = params.require(:menuf10t).permit(:fecha) 
    session[:fecha_f10] = @fecha

    @sorteo = params.require(:menuf10t).permit(:sorteot_id) 
    session[:sorteot_f10] = @sorteo.values[0]

    redirect_to menuf10ts_path and return 
  end

  def update
  end

 
  def destroy
  end


private

def menuf10t_params
      params.require(:menuf10t).permit!
end
 
end
