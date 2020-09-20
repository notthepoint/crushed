class SessionsController < ApplicationController
	skip_before_action :authorized

	def new
	end

  def create
		@user = User.find_by(username: params[:username])

		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id

			redirect_to '/admin/coins'
		else
			render 'new'
		end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url
	end
end
