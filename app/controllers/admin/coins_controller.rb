class Admin::CoinsController < ApplicationController
	before_action :set_coin, only: [:edit, :show, :update, :destroy]

	def index
		@coins = Coin.all
	end

	def show
	end

	def new
		@coin = Coin.new
	end

	def edit
	end

	def create
		@coin = Coin.new(coin_params)

		if @coin.save
			redirect_to admin_coins_url, notice: "Coin saved"
		else
			flash.now[:alert] = "Error saving coin"
			render 'new'
		end
	end

	def update
		if @coin.update(coin_params)
			redirect_to admin_coins_url
		else
			flash.now[:alert] = "Error updating coin"
			render 'edit'
		end
	end

	def destroy
		@coin.destroy
		redirect_to admin_coins_url
	end

	private

	def set_coin
		@coin = Coin.find(params[:id])
	end

	def coin_params
		params.require(:coin).permit(:title, :description, :address, :city, :country)
	end
end
