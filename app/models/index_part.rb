class IndexPart < ApplicationRecord
		belongs_to :index
		validates :ticker, :name, :initial_price, presence: true
		after_save :refresh_index_value, if: :initial_price_changed?

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

	def return
		if self.index.short
			percentage_change(initial_price, price, 1)
		else
			percentage_change(price, initial_price, 1)
		end
	end

	def refresh_index_value
		self.index.devaluer_multiplier
	end

	def percentage_change(numerator, denominator, precision)
		(((numerator / denominator) - 1) * 100).round(precision)
	end
end
