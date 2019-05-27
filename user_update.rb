require './atcoder_streaker'

client = AtCoderStreaker::TwitterClient.new

client.fetch_mentions.each do |mention|
  user_id = mention.
  if matched = mention.match(ADD_USER_REGEX)
    atcoder_id = matched[1]
    client.add_user(twitter_id, atcoder_id)
  elsif matched = mention.match(REMOVE_USER_REGEX)
    atcoder_id = matched[1]
    client.remove_user(twitter_id, atcoder_id)
  else
    client.mention(twitter_id, 'ツイートの形式が不正だったため、ユーザの登録または削除に失敗しました。')
  end
end