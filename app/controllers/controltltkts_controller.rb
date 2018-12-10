class ControltltktsController < ApplicationController
  before_action :set_controltltkt, only: [:show, :edit, :update, :destroy]

  # GET /controltltkts
  # GET /controltltkts.json
  def index
    @controltltkts = Controltltkt.all
  end

  # GET /controltltkts/1
  # GET /controltltkts/1.json
  def show
  end

  # GET /controltltkts/new
  def new
    @controltltkt = Controltltkt.new
  end

  # GET /controltltkts/1/edit
  def edit
  end

  # POST /controltltkts
  # POST /controltltkts.json
  def create
    @controltltkt = Controltltkt.new(controltltkt_params)

    respond_to do |format|
      if @controltltkt.save
        format.html { redirect_to @controltltkt, notice: 'Controltltkt was successfully created.' }
        format.json { render :show, status: :created, location: @controltltkt }
      else
        format.html { render :new }
        format.json { render json: @controltltkt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controltltkts/1
  # PATCH/PUT /controltltkts/1.json
  def update
    respond_to do |format|
      if @controltltkt.update(controltltkt_params)
        format.html { redirect_to @controltltkt, notice: 'Controltltkt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controltltkt }
      else
        format.html { render :edit }
        format.json { render json: @controltltkt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controltltkts/1
  # DELETE /controltltkts/1.json
  def destroy
    @controltltkt.destroy
    respond_to do |format|
      format.html { redirect_to controltltkts_url, notice: 'Controltltkt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controltltkt
      @controltltkt = Controltltkt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controltltkt_params
      params.require(:controltltkt).permit(:n1, :n2, :n3, :siglas, :limite, :vendida)
    end
end
