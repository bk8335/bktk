class PostsController < ApplicationController

	before_action :authenticate, only: [:admin, :new, :create, :edit, :update, :destroy]
	before_action :find_post, only: [:show, :edit, :update, :destroy]

	def index
		if params[:category].blank?
  		@posts = Post.all.order("created_at DESC")
  	else
  		@category_id = Category.find_by(name: params[:category]).id
  		@posts = Post.where(category_id: @category_id).order("created_at DESC")
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

	def subscriber_signup
		@subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      flash[:success] = "Thanks for signing up - we'll email you when there's a new post!"
      redirect_to root_url
    else
      flash[:error] = "Sorry, please make sure you submit a valid name and email address"
      redirect_to root_url
    end
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
		params.require(:post).permit(:title, :content, :category_id, :image, :slug, :author)
	end

	def find_post
		@post = Post.friendly.find(params[:id])
	end

	def subscriber_params
    params.require(:subscriber).permit(:first_name, :email)
  end

end
