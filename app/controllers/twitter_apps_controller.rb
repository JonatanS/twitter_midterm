## interface between twitter and google maps
## help here: http://www.rubydoc.info/gems/twitter
## http://railscasts.com/episodes/324-passing-data-to-javascript
## http://stackoverflow.com/questions/9214243/rails-geocoder-looping-through-existing-database-and-geocode-by-address-city



class TwitterAppsController < ApplicationController

	def index

		#@twitter_streaming_client = Twitter::Streaming::Client.new(TWITTER_CONFIG)
		@twitter_rest_client = Twitter::REST::Client.new(TWITTER_CONFIG)
		
		# SET DEFAULT VALUES FOR FIRST RUN

		@from_date = params[:from]
		@to_date = params[:to]

		@radius = params[:radius]

		if(@radius == nil) then 
			@radius = '100'
		end

		gon.radius = @radius

		@topics = params[:keyword]
		#@city_name = params[:loc]
		if @topics == nil
			@topics = "pizza"
		end

		if @from_date!="" && @from_date!=nil then
			@topics = @topics + " since:" + @from_date 
		end

		if @to_date!="" && @to_date!=nil then 
			@topics = @topics + " until:" + @to_date
		end

		@city_to_lookup = params[:lookup]
		if @city_to_lookup == nil 
			@city_to_lookup = "New York" 
		end

		gon.city_found = true

		#look up in DB
		@my_city = City.find_by address: @city_to_lookup
		if @my_city != nil then
			@lat = @my_city.latitude
			@lon = @my_city.longitude
			puts 'lat: ' + @lat.to_s
		else
			#use geocoder to add city
			#@my_city = City.new({ :address => @city_to_lookup })
			s = Geocoder.search("#{@city_to_lookup}")
			binding.pry
			if s.count > 0 then
				#create a new city
				c = City.new

				c.latitude = s[0].latitude
				c.longitude = s[0].longitude
				c.address = @city_to_lookup
				c.save
				@my_city = c
			else
				gon.city_found = false
			end
		end

		gon.arr_location_tweets = []
		@twitter_display = []
		if gon.city_found then
			##initLocation is used to center the map (and specify zoom level based on radius)
			gon.initLocation = Location_Tweet.new("",@my_city.latitude,@my_city.longitude,@radius,"","")

			#@twitter_rest_client.search(@topics, result_type: "recent", geocode: "#{@lat},#{@lon},#{@radius}mi").take(100).each do |tweet|
			@twitter_rest_client.search(@topics, result_type: "recent", geocode: "#{@lat},#{@lon},#{@radius}mi").take(100).each do |tweet|
	  			#binding.pry
	  			if (tweet.geo?) then
					gon.arr_location_tweets<< Location_Tweet.new(tweet.text, tweet.geo.lat.to_f, tweet.geo.long.to_f, \
						tweet.retweeted? ? tweet.retweet_count : 0, tweet.created_at.to_datetime, tweet.media? ? tweet.media[0].media_url.to_s : "")
				end
			end
			@twitter_display = gon.arr_location_tweets
		end
	end
end
