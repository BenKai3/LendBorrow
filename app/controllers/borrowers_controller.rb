class BorrowersController < ApplicationController
  before_action :set_borrower, only: [:show, :edit, :update, :destroy]

  # GET /borrowers
  # GET /borrowers.json
  def index
    @borrowers = Borrower.all
  end

  # GET /borrowers/1
  # GET /borrowers/1.json
  def show
    @history = History.where(borrower_id: session[:user_id])
  end

  # GET /borrowers/new
  def new
    @borrower = Borrower.new
  end

  # GET /borrowers/1/edit
  def edit
  end

  # POST /borrowers
  # POST /borrowers.json
  def create
    @borrower = Borrower.new(borrower_params)

    respond_to do |format|
      if @borrower.save
        format.html { redirect_to '/signout', notice: 'Borrower was successfully created.' }
        format.json { render :show, status: :created, location: @borrower }
      else
        format.html { render :new }
        format.json { render json: @borrower.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /borrowers/1
  # PATCH/PUT /borrowers/1.json
  def update
    respond_to do |format|
      if @borrower.update(borrower_params)
        format.html { redirect_to @borrower, notice: 'Borrower was successfully updated.' }
        format.json { render :show, status: :ok, location: @borrower }
      else
        format.html { render :edit }
        format.json { render json: @borrower.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /borrowers/1
  # DELETE /borrowers/1.json
  def destroy
    @borrower.destroy
    respond_to do |format|
      format.html { redirect_to borrowers_url, notice: 'Borrower was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_borrower
      @borrower = Borrower.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def borrower_params
      params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money, :purpose, :description, :raised, :created_at, :updated_at)
    end
end
