class Position < ApplicationRecord

	belongs_to :post
	validates :asset, :long_or_short, :initial_price, :post_id, :currency, presence: true

	def position_return(latest_price, initial_price)
		if long_or_short == 'short'
			(((latest_price / initial_price) - 1) * 100).round(2) * -1
		else
			(((latest_price / initial_price) - 1) * 100).round(2)
		end 
	end

	def get_latest_price(ticker)
		if ticker.nil?
			return "N/A"
		else
		((JSON.parse(open("https://api.iextrading.com/1.0/stock/#{ticker}/quote").read)['latestPrice']))
		end
	end

end
