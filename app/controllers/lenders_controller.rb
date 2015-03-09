class LendersController < ApplicationController
  before_action :set_lender, only: [:show, :edit, :update, :destroy]

  # GET /lenders
  # GET /lenders.json
  def index
    @lenders = Lender.all
  end

  # GET /lenders/1
  # GET /lenders/1.json
  def show
    @history_lent_to = History.where(lender_id: session[:user_id])
    @borrowers = Borrower.all
    @lender1 = Lender.find(params[:id])
  end

  def lend
    @borrower_lent_to = History.new(amount: params[:lend], lender_id: session[:user_id], borrower_id: params[:id])
    @borrower_lent_to.save

    puts ''
    puts '@borrower_lent_to: '+@borrower_lent_to.amount.to_s+" "+@borrower_lent_to.lender.first_name.to_s+" "+@borrower_lent_to.borrower.first_name.to_s
    puts ''

    @borrower_lent = Borrower.find(params[:id])
    puts ''
    puts '@borrower_lent.raised: '+@borrower_lent.raised.to_s
    puts ''

    @amount = @borrower_lent.raised.to_i

    @amount = (@amount+@borrower_lent_to.amount.to_i)
    puts ''
    puts '@borrower_lent.raised: '+@borrower_lent.raised.to_s
    puts ''

    @add_lent_to_borrower = Borrower.where(id: params[:id]).update_all(raised: @amount)

    @Lender_lending = Lender.find(session[:user_id])
    puts ''
    puts '@Lender_lending.money: '+@Lender_lending.money.to_s
    puts ''

    @amount = @Lender_lending.money.to_i

    @amount = (@amount-@borrower_lent_to.amount.to_i)
    puts ''
    puts '@Lender_lending.money: '+@Lender_lending.money.to_s
    puts ''

    @spent_money = Lender.where(id: session[:user_id]).update_all(money: @amount)

    redirect_to :back
  end

  # GET /lenders/new
  def new
    @lender = Lender.new
  end

  # GET /lenders/1/edit
  def edit
  end

  # POST /lenders
  # POST /lenders.json
  def create
    @lender = Lender.new(lender_params)

    respond_to do |format|
      if @lender.save
        format.html { redirect_to '/signout', notice: 'Lender was successfully created.' }
        format.json { render :show, status: :created, location: @lender }
      else
        format.html { render :new }
        format.json { render json: @lender.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lenders/1
  # PATCH/PUT /lenders/1.json
  def update
    respond_to do |format|
      if @lender.update(lender_params)
        format.html { redirect_to @lender, notice: 'Lender was successfully updated.' }
        format.json { render :show, status: :ok, location: @lender }
      else
        format.html { render :edit }
        format.json { render json: @lender.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lenders/1
  # DELETE /lenders/1.json
  def destroy
    @lender.destroy
    respond_to do |format|
      format.html { redirect_to lenders_url, notice: 'Lender was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lender
    #   # @lender = Lender.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lender_params
      params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money, :created_at, :updated_at)
    end
end
