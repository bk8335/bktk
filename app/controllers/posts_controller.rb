class PostsController < ApplicationController

	before_action :authenticate, only: [:admin, :new, :create, :edit, :update, :destroy, :draft_index]
	before_action :find_post, only: [:show, :edit, :update, :destroy]

	def index
		if params[:category].blank?
  		@posts = Post.all.where.not(draft: true).order("created_at DESC")
  		respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  	else
  		@category_id = Category.find_by(name: params[:category]).id
  		@posts = Post.where(draft: false, category_id: @category_id).order("created_at DESC")
  	end
	end

	def draft_index
		if params[:category].blank?
  		@posts = Post.all.where(draft: true).order("created_at DESC")
  	else
  		@category_id = Category.find_by(name: params[:category]).id
  		@posts = Post.where(draft: true, category_id: @category_id).order("created_at DESC")
  	end
	end

	def show
		if request.path != post_path(@post)
			redirect_to @post, status: :moved_permanently
		end
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		if @post.save
			flash[:success] = "The post was created!"
     redirect_to @post
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @post.update(post_params)
			flash[:success] = 'The post was updated!'
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		flash[:success] = 'The post was deleted'
		redirect_to root_path
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
	
	def post_params
		params.require(:post).permit(:title, :content, :category_id, :image, :slug, :author, :draft, :wordcount)
	end

	def find_post
		@post = Post.friendly.find(params[:id])
	end

end
