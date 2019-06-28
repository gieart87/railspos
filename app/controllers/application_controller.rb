class ApplicationController < ActionController::Base
	before_action :authenticate_user!

	layout :layout

  	private
  		# set default layout
  		# if user accessing devise feature then use authentication layout otherwise use application layout
		def layout
			is_a?(DeviseController) ? 'authentication' : 'application'
	  	end
end
