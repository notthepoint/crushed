class CoinsController < ApplicationController
	def index
		@coins = Coin.all
	end

	def show
		@coin = Coin.find_by_id(params[:id])
	end
end
