class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
 
	def set_locale
	  I18n.locale = params[:locale] || I18n.default_locale
	end

	def default_url_options(options={})
	  { locale: I18n.locale }
	end

	private
		def require_signin!
			if current_user.nil?
				flash[:error] =	t 'application.errors.need_logged' 
				redirect_to signin_url
			end
		end
		helper_method :require_signin!
		
		def require_not_signin!
			unless current_user.nil?
				flash[:error] =	t 'application.errors.yet_logged' 
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
