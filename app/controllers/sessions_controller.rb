class SessionsController < ApplicationController
	before_action :require_not_signin!, :except => [:destroy]

	def create
		user = User.find_by(:email => params[:signin][:email])
		
		if user && user.authenticate(params[:signin][:password])
			session[:user_id] = user.id
			redirect_to root_url, :notice => 'Signed in successfully.'
		else
			flash[:error] = "User or password incorrect."
			render :new
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to signin_path, :notice => 'Logged out!'
	end

end