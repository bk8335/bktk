class IndexPart < ApplicationRecord
		belongs_to :index

	def get_latest_price(ticker)
		stock_price = ((JSON.parse(open("https://api.iextrading.com/1.0/stock/#{ticker}/quote").read)['latestPrice']))	
		self.update(price: stock_price, price_last_updated_at: Time.now)
		self.price
	end

	def cached_price
		if self.price_last_updated_at.nil? || self.price_last_updated_at < 1.day.ago
			get_latest_price(self.ticker)
		else
			self.price
		end
	end
end
