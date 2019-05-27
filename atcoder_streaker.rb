require "bundler/setup"
Bundler.require

module AtCoderStreaker
  class TwitterClient
    
    def initialize
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key =        ENV.fetch('CONSUMER_KEY')
        config.consumer_secret =     ENV.fetch('CONSUMER_SECRET')
        config.access_token_secret = ENV.fetch('ACCESS_TOKEN_SECRET')
        config.access_token =        ENV.fetch('ACCESS_TOKEN')
      end

      @crawler = AtCoderProblemsCrawler.new

      @users = [
        {twitter_id: 1133002988375515136, atcoder_id: 'betit0919'}
      ]
    end

    def fetch_mentions
      
    end

    def remind_users
      @users.each do |user|
        remind(user[:twitter_id]) if @crawler.fetch_last_AC_date(user[:atcoder_id]) == Date.today
      end
    end
    
    def add_user(twitter_id, atcoder_id)

    end

    def remove_user(twitter_id, atcoder_id)

    end

    def reply(twitter_id, content)

    end

    private

    def remind(twitter_id)

    end

  end

  
  class AtCoderProblemsCrawler
    def fetch_last_AC_date(user)

    end
  end

end
