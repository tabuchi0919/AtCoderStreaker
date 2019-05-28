require 'open-uri'
require "bundler/setup"
Bundler.require

class AtCoderStreaker
  def initialize
    @twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key =        ENV.fetch('CONSUMER_KEY')
      config.consumer_secret =     ENV.fetch('CONSUMER_SECRET')
      config.access_token_secret = ENV.fetch('ACCESS_TOKEN_SECRET')
      config.access_token =        ENV.fetch('ACCESS_TOKEN')
    end
    @users = []
    @latest_mention_id = 1
  end

  def update_users
    fetch_mentions.each do |mention|
      match_data = mention.text.match(/^@AtCoderStreaker\sadd\s(\w{3,16})$/)
      add_user(mention.user.screen_name, match_data[1]) if match_data      
      match_data = mention.text.match(/^@AtCoderStreaker\sremove\s(\w{3,16})$/)
      remove_user(mention.user.screen_name, match_data[1]) if match_data
    end
    @users.uniq!
  end

  def remind_users
    @users.each do |user|
      remind(user[:twitter_id]) if today_accepted_submission(user[:atcoder_id]).empty?
    end
  end

  private

  def fetch_mentions
    mentions = @twitter_client.mentions_timeline(since_id: @latest_mention_id)
    unless mentions.empty?
      @latest_mention_id = mentions.first.id
    end
    mentions
  end
  
  def add_user(twitter_id, atcoder_id)
    @users << { twitter_id: twitter_id, atcoder_id: atcoder_id }
    reply(twitter_id, "AtCoderID #{atcoder_id}を登録しました。(#{Time.now})")
  end

  def remove_user(twitter_id, atcoder_id)
    @users.delete(twitter_id: twitter_id, atcoder_id: atcoder_id)
    reply(twitter_id, "AtCoderID #{atcoder_id}を削除しました。(#{Time.now})")
  end

  def remind(twitter_id)
    reply(twitter_id, "今日(#{Date.today})のACがなさそうです。(#{Time.now})")
  end

  def reply(twitter_id, content)
    @twitter_client.update("@#{twitter_id} #{content}")
  end

  def today_accepted_submission(atcoder_id)
    submissions = JSON.parse(open("https://kenkoooo.com/atcoder/atcoder-api/results?user=#{atcoder_id}").read)
    submissions.select do |submission|
      submission['result'] = 'AC' && submission['epoch_second'] >= Date.today.strftime('%s').to_i
    end
  end
end
