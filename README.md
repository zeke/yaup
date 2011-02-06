require 'rubygems'
require 'oauth'
require 'json'

consumer_key = 'lqGD6NG6AtjgWq1H8smWnw'
consumer_secret = 'SDiD1IHNu2_wkPOH59PkPb6lwjk'
token = 'iIZKfru9-EHSvQ6c9tvKtdNQ5KxMftvW'
token_secret = '3l3NLym3ZfakBbx-fYu0kK6YOto'
api_host = 'api.yelp.com'
consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
access_token = OAuth::AccessToken.new(consumer, token, token_secret)
path = "/v2/search?term=#{params[:term]}&location=#{params[:location]}"
result = JSON.parse(access_token.get(path).body)
businesses = result['businesses']

puts JSON.pretty_generate(businesses.first)

for business in businesses
  puts business['name']
  puts business['location']['cross_streets']
  puts business['review_count']
  puts business['rating_img_url_small'].split("/").last.gsub(/stars\_small\_(.*)\.png/, '\\1').gsub("_half", ".5")
  puts "\n"
end
  
padrino g project yaup -t rspec -e haml -c sass -s jquery -d activerecord -b

get :index, :map => "/:location/:term" do
  
end