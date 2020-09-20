class ApplicationController < ActionController::Base
	helper_method :current_user
	helper_method :logged_in?
	before_action  :authorized

	def current_user
		print session[:user_id]
		puts "CURRENT USER??"
		if session[:user_id]
			puts "YEAH SESSSION"
			@current_user ||= User.find(session[:user_id])
		else
			@current_user = nil
		end
	end

	def logged_in?
		!current_user.nil?
	end

	def authorized
		redirect_to root_url unless logged_in?
	end
end
