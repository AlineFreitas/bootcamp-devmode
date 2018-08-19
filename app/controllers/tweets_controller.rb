class TweetsController < ApplicationController
    def create
        @tweet = current_user.tweets.new(tweet_params)
        
        if @tweet.save
          redirect_to root_path, notice: 'Tweet criado!'
        else
          redirect_to :root, notice: 'Tweet não criado!'
        end
    end

    def show
      @tweet = Tweet.find(params[:id])
    end
    
    private
      def tweet_params
        params.require(:tweet).permit(:content)
      end
end