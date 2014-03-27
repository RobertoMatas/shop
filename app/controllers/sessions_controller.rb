class SessionsController < ApplicationController
	before_action :require_not_signin!, :except => [:destroy]

	def create
		sign_in params[:signin][:email], params[:signin][:password]
		if current_user.nil?
		 	flash[:error] = "User or password incorrect."
			render :new
		else
			redirect_to root_url, :notice => 'Signed in successfully.'
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to signin_path, :notice => 'Logged out!'
	end

end