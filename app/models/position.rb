class Position < ApplicationRecord

	belongs_to :post
	validates :asset, :long_or_short, :initial_price, :post_id, presence: true

end
