class IndicesController < ApplicationController

	def show
		@indexes = Index.all
	end
end
