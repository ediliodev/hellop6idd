class TicketsganadorestsController < ApplicationController
  before_action :set_ticketsganadorest, only: [:show, :edit, :update, :destroy]

  # GET /ticketsganadorests
  # GET /ticketsganadorests.json
  def index
    # @ticketsganadorests = Ticketsganadorest.all
    #Buscaremos tickets ganadores no pagos. Los tickets pagos no me interesan por ahora.
    #Ticket ganadores no pagos.ids
    @ticketsganadorests = Ticketsganadorest.where(:ticket_id => [Ticket.where(:ganador => "si", :pago => nil).ids])
  
  end

  # GET /ticketsganadorests/1
  # GET /ticketsganadorests/1.json
  def show
  end

  # GET /ticketsganadorests/new
  def new
    @ticketsganadorest = Ticketsganadorest.new
  end

  # GET /ticketsganadorests/1/edit
  def edit
  end

  # POST /ticketsganadorests
  # POST /ticketsganadorests.json
  def create
    @ticketsganadorest = Ticketsganadorest.new(ticketsganadorest_params)

    respond_to do |format|
      if @ticketsganadorest.save
        format.html { redirect_to @ticketsganadorest, notice: 'Ticketsganadorest was successfully created.' }
        format.json { render :show, status: :created, location: @ticketsganadorest }
      else
        format.html { render :new }
        format.json { render json: @ticketsganadorest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ticketsganadorests/1
  # PATCH/PUT /ticketsganadorests/1.json
  def update
    respond_to do |format|
      if @ticketsganadorest.update(ticketsganadorest_params)
        format.html { redirect_to @ticketsganadorest, notice: 'Ticketsganadorest was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticketsganadorest }
      else
        format.html { render :edit }
        format.json { render json: @ticketsganadorest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticketsganadorests/1
  # DELETE /ticketsganadorests/1.json
  def destroy
    @ticketsganadorest.destroy
    respond_to do |format|
      format.html { redirect_to ticketsganadorests_url, notice: 'Ticketsganadorest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticketsganadorest
      @ticketsganadorest = Ticketsganadorest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticketsganadorest_params
      params.require(:ticketsganadorest).permit(:ticket_id, :jugada, :montoapostado, :montoacobrar)
    end
end
