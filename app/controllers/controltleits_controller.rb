class ControltleitsController < ApplicationController
  before_action :set_controltleit, only: [:show, :edit, :update, :destroy]

  # GET /controltleits
  # GET /controltleits.json
  def index
    @controltleits = Controltleit.all
  end

  # GET /controltleits/1
  # GET /controltleits/1.json
  def show
  end

  # GET /controltleits/new
  def new
    @controltleit = Controltleit.new
  end

  # GET /controltleits/1/edit
  def edit
  end

  # POST /controltleits
  # POST /controltleits.json
  def create
    @controltleit = Controltleit.new(controltleit_params)

    respond_to do |format|
      if @controltleit.save
        format.html { redirect_to @controltleit, notice: 'Controltleit was successfully created.' }
        format.json { render :show, status: :created, location: @controltleit }
      else
        format.html { render :new }
        format.json { render json: @controltleit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controltleits/1
  # PATCH/PUT /controltleits/1.json
  def update
    respond_to do |format|
      if @controltleit.update(controltleit_params)
        format.html { redirect_to @controltleit, notice: 'Controltleit was successfully updated.' }
        format.json { render :show, status: :ok, location: @controltleit }
      else
        format.html { render :edit }
        format.json { render json: @controltleit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controltleits/1
  # DELETE /controltleits/1.json
  def destroy
    @controltleit.destroy
    respond_to do |format|
      format.html { redirect_to controltleits_url, notice: 'Controltleit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controltleit
      @controltleit = Controltleit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controltleit_params
      params.require(:controltleit).permit(:n1, :n2, :n3, :siglas, :limite, :vendida)
    end
end
