class StaticPagesController < ApplicationController

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

	private

	def subscriber_params
    params.require(:subscriber).permit(:first_name, :email)
  end
end
