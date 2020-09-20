class CoinsController < ApplicationController
	skip_before_action :authorized
	def index
		@coins = Coin.all
	end

	def show
		@coin = Coin.find_by_id(params[:id])
	end
end
