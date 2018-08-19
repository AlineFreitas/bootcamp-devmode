class PagesController < ApplicationController
	def home
      user_signed_in?
        @tweet = current_user.tweets.build
	end
end