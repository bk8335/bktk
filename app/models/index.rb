class Index < ApplicationRecord
		has_many :index_parts
		after_create :devaluer_multiplier

		def raw_price
			index_value = 0
			self.index_parts.each do |index_part|
				index_value += index_part.price * index_part.number_of_shares
			end
			index_value
		end

		def index_price
			(raw_price * self.devaluer).round(2)
		end

		def initial_raw_price
			intial_index_value = 0
			self.index_parts.each do |index_part|
				intial_index_value += index_part.initial_price * index_part.number_of_shares
			end
			intial_index_value
		end

		def devaluer_multiplier
			self.update(devaluer: self.starting_level / initial_raw_price)
		end

		def index_price_change
			if self.short
				percentage_change(starting_level, index_price, 2)
			else
				percentage_change(index_price, starting_level, 2)
			end
		end

		def percentage_change(numerator, denominator, precision)
			(((numerator / denominator) - 1) * 100).round(precision)
		end
end
