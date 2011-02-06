require 'uri'
class Search
  
  attr_accessor :term, :location, :businesses
  
  def initialize(term, location)
    self.term = term
    self.location = location
  end
  
  def results
    return @businesses if @businesses.present?
    
    consumer_key = 'lqGD6NG6AtjgWq1H8smWnw'
    consumer_secret = 'SDiD1IHNu2_wkPOH59PkPb6lwjk'
    token = 'iIZKfru9-EHSvQ6c9tvKtdNQ5KxMftvW'
    token_secret = '3l3NLym3ZfakBbx-fYu0kK6YOto'
    api_host = 'api.yelp.com'
    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
    access_token = OAuth::AccessToken.new(consumer, token, token_secret)
    
    path = URI.escape("/v2/search?term=#{self.term}&location=#{self.location}")
    result = JSON.parse(access_token.get(path).body)
      
  	@businesses = result['businesses'].map do |business_json|
      # raise business_json.inspect
      Business.new(business_json)
  	end.sort_by(&:review_count).reverse
  end

  
end