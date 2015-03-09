class SessionsController < ApplicationController

	def index
	end

	def new
		@user
		# @lender = Lender.new
		# @borrower = Borrower.new
	end

	def create
		puts ''
		puts "params[:lender]: "+params[:lender].to_s
		puts "params[:borrower]: "+params[:borrower].to_s
		puts ''
		if params[:lender] == 'on'
			user = Lender.authenticate(params[:email], params[:password])
		elsif params[:borrower] == 'on'
			user = Borrower.authenticate(params[:email], params[:password])
		end
		puts ''
		puts "user: "+user.to_s
		puts ''
		if user.nil?
			flash.now[:error] = "Please check your email/password combination, and make sure you select either 'Lender' or 'Borrower'."
			render :new
		else
			sign_in user
			redirect_to user
		end
	end

	def destroy
		sign_out
		redirect_to '/'
	end
end
