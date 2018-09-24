class IndexPartsController < ApplicationController

	before_action :authenticate, only: [:admin, :new, :create, :edit, :update, :destroy, :draft_index]
	before_action :find_index_part, only: [:show, :edit, :update, :destroy]

	def show
		if request.path != post_path(@index_part)
			redirect_to @index_part
		end
	end

	def new
		@index_part = IndexPart.new
	end

	def create
		@index_part = IndexPart.new(index_part_params)
		if @index_part.save
			flash[:success] = "The index_part was created!"
		end
		render 'new'
	end

	def edit
	end

	def update
		if @index_part.update(index_part_params)
			flash[:success] = 'The index part was updated!'
			redirect_to @index_part
		else
			render 'edit'
		end
	end


def admin
		redirect_to root_path if authenticate
end

protected
	def authenticate
		authenticate_or_request_with_http_basic do |username, password|
			admin_username = Rails.application.secrets.admin_username
   		admin_password = Rails.application.secrets.admin_password
   		session[:admin] = true if (username == admin_username && password == admin_password) 
		end
	end

private

def index_part_params
		params.require(:index_part).permit(:index_id, :ticker, :name, :industry, :number_of_shares, :initial_price)
	end

def find_index_part
		@index_part = IndexPart.find(params[:id])
	end
end
