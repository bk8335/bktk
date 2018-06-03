class Position < ApplicationRecord

	belongs_to :post
	validates :asset, :ticker, :long_or_short, :initial_price, :post_id, presence: true

end
