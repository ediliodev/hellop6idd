class ManageuserbtsController < ApplicationController
  before_action :set_manageuserbt, only: [:show, :edit, :update, :destroy]

  # GET /manageuserbts
  # GET /manageuserbts.json
  def index
    @manageuserbts = Manageuserbt.all
    @realusers = User.all
  end

  # GET /manageuserbts/1
  # GET /manageuserbts/1.json
  def show
  end

  # GET /manageuserbts/new
  def new
    @manageuserbt = Manageuserbt.new
  end

  # GET /manageuserbts/1/edit
  def edit
  end

  # POST /manageuserbts
  # POST /manageuserbts.json
  def create
    @manageuserbt = Manageuserbt.new(manageuserbt_params)
    @manageuserbt.modificadopor = current_user.email
     @manageuserbt.password = "********" #edito el campo password para no guardarlo plain en la DB de este Modelo.

    @reset_user =   User.where(:email => manageuserbt_params[:email]).first
    if manageuserbt_params[:password].empty? 
      redirect_to new_manageuserbt_path, notice: 'Password - No puede estar en blanco' and return
    end
      @reset_user.password =  manageuserbt_params[:password]
      @reset_user.activo =    manageuserbt_params[:activo]
      
   

    


    respond_to do |format|
      if @manageuserbt.save && @reset_user.save
        format.html { redirect_to root_path, notice: 'Manageuserbt was successfully created.' }
        format.json { render :show, status: :created, location: @manageuserbt }
      else
        format.html { render :new }
        format.json { render json: @manageuserbt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manageuserbts/1
  # PATCH/PUT /manageuserbts/1.json
  def update
    
    respond_to do |format|
      if @manageuserbt.update(manageuserbt_params)
        format.html { redirect_to @manageuserbt, notice: 'Manageuserbt was successfully updated.' }
        format.json { render :show, status: :ok, location: @manageuserbt }
      else
        format.html { render :edit }
        format.json { render json: @manageuserbt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manageuserbts/1
  # DELETE /manageuserbts/1.json
  def destroy
    @manageuserbt.destroy
    respond_to do |format|
      format.html { redirect_to manageuserbts_url, notice: 'Manageuserbt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manageuserbt
      @manageuserbt = Manageuserbt.find(params[:id])
      @real_user_edit = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manageuserbt_params
      params.require(:manageuserbt).permit(:email, :password, :activo)
    end
end
