require "bundler/setup"
Bundler.require

module AtCoderStreaker
  class TwitterClient
    
    def initialize
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV.fetch('CONSUMER_KEY')
        config.consumer_secret = ENV.fetch('CONSUMER_SECRET')
        config.access_token_secret = ENV.fetch('ACCESS_TOKEN_SECRET')
        config.access_token = ENV.fetch('ACCESS_TOKEN')
      end

      @users = [
        [1133002988375515136, 'betit0919']
      ]
    end

    def fetch_mentions
      
    end

    def remind
      
    end

    private

    def add_user(tweet)

    end

    def remove_user(tweet)

    end

  end

end
