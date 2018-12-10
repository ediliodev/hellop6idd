class MenuposrventadiaactualtsController < ApplicationController


  def index
    @dia = session[:fecha_venta_dia].values.reverse.join("-") # para la consulta de by_day(fehca en ingles yyyy-mm-dd)    
    @valor = Jugadalot.by_day(@dia).where(:ticket_id => Ticket.by_day(@dia).where(:user_id => current_user.id , :activo => "si").ids ).sum(:monto)
    
    @dia = session[:fecha_venta_dia].values.join("-") # para el show dd-mm-aaaa
   # session[:fecha_venta_dia] = nil
    
    @venta_sorteo_nacional_noche =  Jugadalot.by_day(@dia).where(:ticket_id => Ticket.by_day(@dia).where(:user_id => current_user.id , :activo => "si").ids, :sorteot_id => Sorteot.where(:sigla => "01") ).sum(:monto)
    @venta_sorteo_ganamas =         Jugadalot.by_day(@dia).where(:ticket_id => Ticket.by_day(@dia).where(:user_id => current_user.id , :activo => "si").ids, :sorteot_id => Sorteot.where(:sigla => "02") ).sum(:monto)
    @venta_sorteo_leidsa =          Jugadalot.by_day(@dia).where(:ticket_id => Ticket.by_day(@dia).where(:user_id => current_user.id , :activo => "si").ids, :sorteot_id => Sorteot.where(:sigla => "03") ).sum(:monto)
    @venta_sorteo_real =            Jugadalot.by_day(@dia).where(:ticket_id => Ticket.by_day(@dia).where(:user_id => current_user.id , :activo => "si").ids, :sorteot_id => Sorteot.where(:sigla => "04") ).sum(:monto)
    @venta_sorteo_nyn =             Jugadalot.by_day(@dia).where(:ticket_id => Ticket.by_day(@dia).where(:user_id => current_user.id , :activo => "si").ids, :sorteot_id => Sorteot.where(:sigla => "05") ).sum(:monto)
    @venta_sorteo_nyt =             Jugadalot.by_day(@dia).where(:ticket_id => Ticket.by_day(@dia).where(:user_id => current_user.id , :activo => "si").ids, :sorteot_id => Sorteot.where(:sigla => "06") ).sum(:monto)
    @venta_sorteo_loteka =          Jugadalot.by_day(@dia).where(:ticket_id => Ticket.by_day(@dia).where(:user_id => current_user.id , :activo => "si").ids, :sorteot_id => Sorteot.where(:sigla => "07") ).sum(:monto)



    #Esto para evitar que el consorcio y los datos del reporte (Header Titulo, telefono..) no salgan en blanco si el usuario genera el reporte luego de un logout-login y sorteros cerrados o no hace / imprime tickets de jutagadas. Reasigno el valor de las variables de session :consorio, etc..
     @consorcio_interno = Consorciot.where(:id => current_user.consorciot_id.to_i).first # Provisional, hasta que arreglemos la relacion has_many entre User y modelo Consorciot. ok ted. 
     session[:consorcio] = @consorcio_interno.nombre
     session[:telefono] = @consorcio_interno.telefono
     session[:siglas] = current_user.siglas

    @st = ""
    @font = "|2C" # Tamanio de las letras.

    @data = "" # Hacer un espacion para la separacion del titulo. Estetica del reporte. ok ted.
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    @data = "Reporte de Venta:" 
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    @data = "" # Hacer un espacion para la separacion del titulo. Estetica del reporte. ok ted.
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    @dia = session[:fecha_venta_dia].values.join("-")

    @data = "Dia: " + @dia.to_s # aqui tiene este valor: @dia = session[:fecha_venta_dia].values.join("-")
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"
    

    @data = "Sucursal: " + current_user.email.split("@")[0].to_s
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"
    
    
    @data = "NN: $" + ActionController::Base.helpers.number_to_currency(@venta_sorteo_nacional_noche.to_s, :unit => "", :delimiter => ",", :precision => 0, :separator => ".")
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    @data = "GM: $" + ActionController::Base.helpers.number_to_currency(@venta_sorteo_ganamas.to_s, :unit => "", :delimiter => ",", :precision => 0, :separator => ".")
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    @data = "LE: $" + ActionController::Base.helpers.number_to_currency(@venta_sorteo_leidsa.to_s, :unit => "", :delimiter => ",", :precision => 0, :separator => ".")
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    @data = "RE: $" + ActionController::Base.helpers.number_to_currency(@venta_sorteo_real.to_s, :unit => "", :delimiter => ",", :precision => 0, :separator => ".")
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    @data = "NYN:$" + ActionController::Base.helpers.number_to_currency(@venta_sorteo_nyn.to_s, :unit => "", :delimiter => ",", :precision => 0, :separator => ".")
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    @data = "NYT:$" + ActionController::Base.helpers.number_to_currency(@venta_sorteo_nyt.to_s, :unit => "", :delimiter => ",", :precision => 0, :separator => ".")
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    @data = "LKA:$" + ActionController::Base.helpers.number_to_currency(@venta_sorteo_loteka.to_s, :unit => "", :delimiter => ",", :precision => 0, :separator => ".")
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"



    #@data = "Venta: $" + @valor.to_s # number_to_currency(@valor, :unit => "", :delimiter => ",", :precision => 0, :separator => ".")
    
    @data = "Venta Total: $" + ActionController::Base.helpers.number_to_currency(@valor.to_s, :unit => "", :delimiter => ",", :precision => 0, :separator => ".")
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    @data = "" # Hacer un espacion para la separacion del titulo. Estetica del reporte. ok ted.
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    @font = "|1C"
    @data = "Consultado el: " + Time.now.strftime("%d/%m/%Y (%H:%M:%S)").to_s 
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    @data = "" # Hacer un espacion para la separacion del titulo. Estetica del reporte. ok ted.
    @st += "printer.printNormal(POSPrinterConst.PTR_S_RECEIPT, ESC + "  + %Q{"#{@font}"} + " + " +  %Q{ " #{@data}"} + " + LF);"

    session[:fecha_venta_dia] = nil # Limpio la variable para evitar cookie oversize en el cliente.
  
  end


  def show
  end

  def new
      @menuposrventadiaactualt = Menuposrventadiaactualt.new
  end

  def edit
  end

  
  def create
    @fecha = params.require(:menuposrventadiaactualt).permit(:fecha) 
    session[:fecha_venta_dia] = @fecha
    redirect_to menuposrventadiaactualts_path and return 
  end

  def update
  end

  def destroy
  end

 
end
