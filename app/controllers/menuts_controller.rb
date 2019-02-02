class MenutsController < ApplicationController

#logica del controlador en limpio, ok ted. mostrar el listado del menu la vista index.html
  def index
  end

 
  def show
  end

  def new  
  end

  
  def edit
  end

 
  def create
  end

 
  def update 
  end

 
  def destroy  
  end

  def calculadora    
  end

  def ayudacomando
  end

def menut_params
      params.require(:menut).permit!
end
 
end
