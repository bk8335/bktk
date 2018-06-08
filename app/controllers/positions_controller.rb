class PositionsController < ApplicationController

	def portfolio
    @positions = Position.all
  end
  
end
