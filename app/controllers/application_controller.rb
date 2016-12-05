class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def index
    end

    def search
        Tweet.transaction do
            Tweet.delete_all
            client.search(params[:q], result_type: 'recent').take(15).collect do |tweet|
                Tweet.new({
                    avatar: tweet.user.profile_image_uri.to_s,
                    name: tweet.user.screen_name,
                    content: tweet.text,
                    time: tweet.created_at,
                }).save
            end
        end
        redirect_to tweets_url
    end

    def tweets
    end

    def client
        @client ||= Twitter::REST::Client.new do |config|
            config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
            config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
        end
    end
end
