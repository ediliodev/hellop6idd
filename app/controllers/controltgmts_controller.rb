class ControltgmtsController < ApplicationController
  before_action :set_controltgmt, only: [:show, :edit, :update, :destroy]

  # GET /controltgmts
  # GET /controltgmts.json
  def index
    @controltgmts = Controltgmt.all
  end

  # GET /controltgmts/1
  # GET /controltgmts/1.json
  def show
  end

  # GET /controltgmts/new
  def new
    @controltgmt = Controltgmt.new
  end

  # GET /controltgmts/1/edit
  def edit
  end

  # POST /controltgmts
  # POST /controltgmts.json
  def create
    @controltgmt = Controltgmt.new(controltgmt_params)

    respond_to do |format|
      if @controltgmt.save
        format.html { redirect_to @controltgmt, notice: 'Controltgmt was successfully created.' }
        format.json { render :show, status: :created, location: @controltgmt }
      else
        format.html { render :new }
        format.json { render json: @controltgmt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /controltgmts/1
  # PATCH/PUT /controltgmts/1.json
  def update
    respond_to do |format|
      if @controltgmt.update(controltgmt_params)
        format.html { redirect_to @controltgmt, notice: 'Controltgmt was successfully updated.' }
        format.json { render :show, status: :ok, location: @controltgmt }
      else
        format.html { render :edit }
        format.json { render json: @controltgmt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /controltgmts/1
  # DELETE /controltgmts/1.json
  def destroy
    @controltgmt.destroy
    respond_to do |format|
      format.html { redirect_to controltgmts_url, notice: 'Controltgmt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_controltgmt
      @controltgmt = Controltgmt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def controltgmt_params
      params.require(:controltgmt).permit(:n1, :n2, :n3, :siglas, :limite, :vendida)
    end
end
