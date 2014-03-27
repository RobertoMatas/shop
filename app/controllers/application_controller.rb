class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	private
		def require_signin!
			if current_user.nil?
				flash[:error] =	"You need to sign in or sign up before continuing."
				redirect_to signin_url
			end
		end
		helper_method :require_signin!
		
		def require_not_signin!
			unless current_user.nil?
				flash[:error] =	"You are already logged, please sign out before if you want continue"
				redirect_to root_url
			end
		end
		helper_method :require_not_signin!

		def current_user
			@current_user ||= User.find(session[:user_id]) if session[:user_id]
		end
		helper_method :current_user

		def sign_in(user_email, pwd)
			user = User.find_by(:email => user_email)
			session[:user_id] = user.id if user && user.authenticate(pwd)
		end
		helper_method :sign_in
end
