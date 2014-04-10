class SessionsController < ApplicationController
	before_action :require_not_signin!, :except => [:destroy]

	def create
		sign_in params[:signin][:email], params[:signin][:password]
		if current_user.nil?
		 	flash[:error] = t('.error')
			render :new
		else
			redirect_to root_url, :notice => t('.success')
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to signin_path, :notice => t('.success')
	end

end