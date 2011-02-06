class Yaup < Padrino::Application
  register SassInitializer
  register Padrino::Mailer
  register Padrino::Helpers

  ##
  # Application configuration options
  #
  # set :raise_errors, true     # Show exceptions (default for development)
  # set :public, "foo/bar"      # Location for static assets (default root/public)
  # set :reload, false          # Reload application files (default in development)
  # set :default_builder, "foo" # Set a custom form builder (default 'StandardFormBuilder')
  # set :locale_path, "bar"     # Set path for I18n translations (defaults to app/locale/)
  # enable  :sessions           # Disabled by default
  # disable :flash              # Disables rack-flash (enabled by default if sessions)
  # layout  :my_layout          # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
  #
  
  get "/" do
    render "index"
  end

  get :index, :map => '/:location/:term' do
  # get :index, :with => [:location, :term]  do
    consumer_key = 'lqGD6NG6AtjgWq1H8smWnw'
    consumer_secret = 'SDiD1IHNu2_wkPOH59PkPb6lwjk'
    token = 'iIZKfru9-EHSvQ6c9tvKtdNQ5KxMftvW'
    token_secret = '3l3NLym3ZfakBbx-fYu0kK6YOto'
    api_host = 'api.yelp.com'
    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
    access_token = OAuth::AccessToken.new(consumer, token, token_secret)
    
    path = "/v2/search?term=#{params[:term]}&location=#{params[:location]}"
    result = JSON.parse(access_token.get(path).body)

  	@businesses = result['businesses'].map do |business_json|
      Business.new(business_json)
  	end.sort_by(&:review_count).reverse

    render "search"
  end

  ##
  # You can configure for a specified environment like:
  #
  #   configure :development do
  #     set :foo, :bar
  #     disable :asset_stamp # no asset timestamping for dev
  #   end
  #

  ##
  # You can manage errors like:
  #
  #   error 404 do
  #     render 'errors/404'
  #   end
  #
end