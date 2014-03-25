class SessionsController < ApplicationController

	def create
		user = User.where(:name => params[:signin][:name]).first

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