# twitter-api-search
#  Usage
  Install the gem.

gem install twitter-search
Require the gem.

require 'twitter_search'
Set up a TwitterSearch::Client. Name your client (a.k.a. ‘user agent’) to something meaningful, such as your app’s name. This helps Twitter Search answer any questions about your use of the API.

@client = TwitterSearch::Client.new 'politweets'
Request tweets by calling the query method of your client.

@tweets = @client.query :q => 'twitter search'
Search Operators
The following operator examples find tweets…

:q => ‘twitter search’ – containing both twitter and search. This is the default operator.


@tweets = @client.query :q => 'programmé', :lang => 'en'
Result pagination
Alter the number of Tweets returned per page with the :rpp key. Stick with 10, 15, 20, 25, 30, or 50.

@tweets = @client.query :q => 'Boston Celtics', :rpp => '30'


Schema:

create_table "tweets", :force => true do |t|
  t.string   "user_name",          :limit => 20,  :default => "", :null => false
  t.string   "body",               :limit => 140, :default => "", :null => false
  t.datetime "created_at",                                        :null => false
  t.datetime "updated_at",                                        :null => false
  t.integer  "twitter_id",         :limit => 11
end

add_index "tweets", ["created_at"], :name => "index_tweets_on_created_at"
add_index "tweets", ["twitter_id"], :name => "index_tweets_on_twitter_id"
Hit the API in your rake task (write the code in a class so it can be easily tested):

class Twitter
  def self.import!
    # the implementation is up to you
  end
end
Since I don’t have the cron API memorized, I like to create cron jobs with a handy little tool called crondle:

require 'lib/crondle'

Crondle.define_jobs do |builder|
  rails_root = '/var/www/apps/politweets/current'

  [3, 9, 15, 21, 27, 33, 39, 45, 51, 57].each do |minute|
    builder.desc "Import tweets at #{minute} past the hour"
    builder.job "#{rails_root}/script/runner Twitter.import!", :minute => minute
  end
end
Run the crondle script to get the text that you’ll put in crontab -e:

# Import tweets at 3 past the hour
3 * * * * /var/www/apps/politweets/current/script/runner Twitter.import!

# Import tweets at 9 past the hour
9 * * * * /var/www/apps/politweets/current/script/runner Twitter.import!
