class ApplicationController < ActionController::Base
	rescue_from CanCan::AccessDenied do |exception|
		respond_to do |format|
			format.json { head :forbidden, content_type: 'text/html' }
			format.html {
				redirect_to main_app.root_url
				flash[:error] = exception.message
			}
			format.js   { head :forbidden, content_type: 'text/html' }
		end
	end

	protect_from_forgery with: :exception

	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :authenticate_user!

	layout :layout


  	private
  		# set default layout
  		# if user accessing devise feature then use authentication layout otherwise use application layout
		def layout
			is_a?(DeviseController) ? 'authentication' : 'application'
	  	end

	  	def configure_permitted_parameters
               devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password)}
               devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :current_password)}
       	end
end
